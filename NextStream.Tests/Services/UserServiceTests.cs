using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.EntityFrameworkCore;
using NextStream.Services;
using NextStream.DataAccessLayer;
using NextStream.Services.DataTransferObjects;
using System;
using System.Linq;

namespace NextStream.Tests
{
    [TestClass]
    public class UserServiceTests
    {
        private NextStreamContext CreateDbContext()
        {
            var options = new DbContextOptionsBuilder<NextStreamContext>()
                .UseInMemoryDatabase(Guid.NewGuid().ToString())
                .Options;
            return new NextStreamContext(options);
        }

        [TestMethod]
        public void GetUser_ReturnsUser_WhenExists()
        {
            var dbContext = CreateDbContext();
            dbContext.Users.Add(new User { Id = 1, Email = "test@mail.com", PasswordHash = "pw" });
            dbContext.SaveChanges();

            var userService = new UserService(dbContext, new UserDataService());
            var result = userService.GetUser("test@mail.com");

            Assert.IsNotNull(result);
            Assert.AreEqual("test@mail.com", result.Email);
        }

        [TestMethod]
        public void GetUser_ReturnsNull_WhenNotExists()
        {
            var dbContext = CreateDbContext();
            var userService = new UserService(dbContext, new UserDataService());
            var result = userService.GetUser("notfound@mail.com");
            Assert.IsNull(result);
        }

        [TestMethod]
        public void UpdateProfileColor_UpdatesColor()
        {
            var dbContext = CreateDbContext();
            dbContext.Profiles.Add(new Profile { Id = 1, Name = "Prof1", Color = "Red" });
            dbContext.SaveChanges();

            var userDataService = new UserDataService { ProfileId = 1 };
            var userService = new UserService(dbContext, userDataService);

            userService.UpdateProfileColor("Blue");

            var updated = dbContext.Profiles.First(p => p.Id == 1);
            Assert.AreEqual("Blue", updated.Color);
        }

        [TestMethod]
        public void UpdateProfileName_UpdatesName()
        {
            var dbContext = CreateDbContext();
            dbContext.Profiles.Add(new Profile { Id = 2, Name = "Old", Color = "Red" });
            dbContext.SaveChanges();

            var userDataService = new UserDataService { ProfileId = 2 };
            var userService = new UserService(dbContext, userDataService);

            userService.UpdateProfileName("NewName");

            var updated = dbContext.Profiles.First(p => p.Id == 2);
            Assert.AreEqual("NewName", updated.Name);
        }

        [TestMethod]
        public void DeleteProfile_RemovesProfile()
        {
            var dbContext = CreateDbContext();
            dbContext.Profiles.Add(new Profile { Id = 5, Name = "DeleteMe", Color = "Green" });
            dbContext.SaveChanges();

            var userDataService = new UserDataService { ProfileId = 5 };
            var userService = new UserService(dbContext, userDataService);

            userService.DeleteProfile();

            Assert.AreEqual(0, dbContext.Profiles.Count());
        }

        [TestMethod]
        public void SetCurrentProfile_SetsCorrectData()
        {
            var dbContext = CreateDbContext();
            dbContext.Profiles.Add(new Profile { Id = 7, Name = "SetMe", Color = "Yellow" });
            dbContext.SaveChanges();

            var userDataService = new UserDataService();
            var userService = new UserService(dbContext, userDataService);

            userService.SetCurrentProfile(7);

            Assert.AreEqual(7, userDataService.ProfileId);
            Assert.AreEqual("SetMe", userDataService.Name);
            Assert.AreEqual("Yellow", userDataService.Color);
        }

        [TestMethod]
        public void GetCurrentProfile_ReturnsProfileDTO_WhenProfileSet()
        {
            var userDataService = new UserDataService
            {
                ProfileId = 4,
                Name = "Profile4",
                Color = "White"
            };

            var userService = new UserService(CreateDbContext(), userDataService);
            var result = userService.GetCurrentProfile();

            Assert.IsNotNull(result);
            Assert.AreEqual(4, result.ID);
            Assert.AreEqual("Profile4", result.Name);
            Assert.AreEqual("White", result.Color);
        }

        [TestMethod]
        public void GetCurrentProfile_ReturnsNull_IfProfileIdNull()
        {
            var userService = new UserService(CreateDbContext(), new UserDataService());
            Assert.IsNull(userService.GetCurrentProfile());
        }

        [TestMethod]
        public void GetMovieHistory_ReturnsNull_WhenNoProfile()
        {
            var userService = new UserService(CreateDbContext(), new UserDataService());
            var result = userService.GetMovieHistory(1);
            Assert.IsNull(result);
        }

        [TestMethod]
        public void GetMovieHistory_ReturnsNull_WhenNoHistory()
        {
            // Arrange
            var dbContext = CreateDbContext();
            dbContext.Profiles.Add(new Profile { Id = 10, Name = "P", Color = "C" });
            dbContext.SaveChanges();

            var userDataService = new UserDataService { ProfileId = 10, Name = "P", Color = "C" };
            var userService = new UserService(dbContext, userDataService);

            // Act
            var result = userService.GetMovieHistory(77);

            // Assert
            Assert.IsNull(result);
        }



        [TestMethod]
        public void ValidateUser_ReturnsFalse_IfUserNotFound()
        {
            var userService = new UserService(CreateDbContext(), new UserDataService());
            Assert.IsFalse(userService.ValidateUser("no@mail.com", "any"));
        }

        [TestMethod]
        public void ValidateUser_ReturnsFalse_IfPasswordWrong()
        {
            var dbContext = CreateDbContext();
            dbContext.Users.Add(new User { Id = 21, Email = "u@mail.com", PasswordHash = BCrypt.Net.BCrypt.HashPassword("correctpw") });
            dbContext.SaveChanges();

            var userService = new UserService(dbContext, new UserDataService());
            Assert.IsFalse(userService.ValidateUser("u@mail.com", "wrongpw"));
        }

        [TestMethod]
        public void ValidateUser_ReturnsTrue_IfPasswordCorrect()
        {
            var dbContext = CreateDbContext();
            var password = "topsecret";
            var hash = BCrypt.Net.BCrypt.HashPassword(password);
            dbContext.Users.Add(new User { Id = 31, Email = "secure@mail.com", PasswordHash = hash });
            dbContext.SaveChanges();

            var userService = new UserService(dbContext, new UserDataService());
            Assert.IsTrue(userService.ValidateUser("secure@mail.com", password));
        }
    }
}
