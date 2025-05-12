using BCrypt.Net;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using NextStream.DataAccessLayer;
using NextStream.Services.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace NextStream.Services
{
    public class UserService(NextStreamContext nextStreamContext, UserDataService userDataService)
    {
        public List<UserProfileDTO> GetProfiles(string username)
        {
            var user = GetUser(username);
            return nextStreamContext.Profiles.Include(profile=>profile.UserProfiles).Where(profile => profile.UserProfiles.Any(userProfile => userProfile.UserId == user.Id)).Select(profile=>new UserProfileDTO()
            {
                ID = profile.Id,
                Name = profile.Name,
                Color = profile.Color
            }).ToList();
        }
        public User? GetUser(string username) 
        {
            return nextStreamContext.Users.FirstOrDefault(user => user.Email == username);
        }

        public void UpdateProfileColor(string color)
        {
            var profile = nextStreamContext.Profiles.FirstOrDefault(profile=>profile.Id == userDataService.ProfileId);

            if (profile == null) return;

            profile.Color = color;
            nextStreamContext.SaveChanges();
        }

        public void UpdateProfileName(string name)
        {
            var profile = nextStreamContext.Profiles.FirstOrDefault(profile => profile.Id == userDataService.ProfileId);

            if (profile == null) return;

            profile.Name = name;
            nextStreamContext.SaveChanges();
        }

        public void DeleteProfile()
        {
            var profile = nextStreamContext.Profiles.FirstOrDefault(profile => profile.Id == userDataService.ProfileId);

            if (profile == null) return;

            nextStreamContext.Remove(profile);
            nextStreamContext.SaveChanges();
        }

        public UserProfileDTO? GetCurrentProfile()
        {
            if(userDataService.ProfileId == null) return null;
            return new UserProfileDTO() { ID = userDataService.ProfileId.Value, Name = userDataService.Name!, Color = userDataService.Color.Trim()};
        }

        public void SetCurrentProfile(int profileId)
        {
            var profile = nextStreamContext.Profiles.FirstOrDefault(profile => profile.Id == profileId);
            userDataService.ProfileId = profile!.Id;
            userDataService.Name = profile.Name;
            userDataService.Color = profile.Color;
        }

        public MovieHistoryDTO? GetMovieHistory(int movieId)
        {
            var profile = GetCurrentProfile();

            if (profile == null) return null;

            var movieHistory = nextStreamContext.MovieHistories.FirstOrDefault(history => history.MovieId == movieId && history.ProfileId == profile.ID);
            if (movieHistory == null || movieHistory.CurrentPositionInSeconds == null) return null;

            return new MovieHistoryDTO() { TimeIndex = movieHistory.CurrentPositionInSeconds.Value };
        }

        public bool ValidateUser(string email, string password)
        {
            var user = nextStreamContext.Users
                .FirstOrDefault(user => user.Email == email);

            if(user == null)
            {
                return false;
            }

            if(BCrypt.Net.BCrypt.Verify(password, user.PasswordHash))
            {
                return true;
            }

            return false;
        }
    }
}
