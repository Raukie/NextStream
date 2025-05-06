using BCrypt.Net;
using NextStream.DataAccessLayer;
using NextStream.Services.DataTransferObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NextStream.Services
{
    public class UserService(NextStreamContext nextStreamContext)
    {
        public User? GetUser(string username) 
        {
            return nextStreamContext.Users.FirstOrDefault(user => user.Email == username);
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
