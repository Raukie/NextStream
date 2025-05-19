using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.EntityFrameworkCore;
using Moq;
using NextStream.DataAccessLayer;
using NextStream.Services;
using NextStream.Services.DataTransferObjects;
using System;

namespace NextStream.Services.Tests
{
    [TestClass]
    public class MovieServiceTests
    {
        private NextStreamContext CreateDbContext()
        {
            var options = new DbContextOptionsBuilder<NextStreamContext>()
                .UseInMemoryDatabase(Guid.NewGuid().ToString())
                .Options;
            return new NextStreamContext(options);
        }

        [TestMethod]
        public void GetMovieToWatch_ReturnsNull_WhenMovieNotFound()
        {
            // Arrange
            var dbContext = CreateDbContext();
            var userServiceMock = new Mock<UserService>(dbContext, new UserDataService());
            var movieService = new MovieService(dbContext, userServiceMock.Object);

            // Act
            var result = movieService.GetMovieToWatch(1);

            // Assert
            Assert.IsNull(result);
        }
    }
}
