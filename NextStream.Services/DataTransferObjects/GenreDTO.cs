using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NextStream.Services.DataTransferObjects
{
    public class GenreDTO
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public int CurrentPage { get; set; } = 0;
        public List<MovieInOverviewDTO> Movies { get; set; } = [];
    }
}
