using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NextStream.Services.DataTransferObjects
{
    public class MovieWatchingDTO
    {
        public int ID { get; set; }
        public string Title { get; set; }
        public string URL { get; set; }
        public int TimeIndex { get; set; }
    }
}
