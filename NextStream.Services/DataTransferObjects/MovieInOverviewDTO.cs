using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NextStream.Services.DataTransferObjects
{
    public class MovieInOverviewDTO
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string ThumbmailFileName { get; set; } = string.Empty;
    }
}
