USE [master]
GO
/****** Object:  Database [NextStream]    Script Date: 5/12/2025 3:36:13 PM ******/
CREATE DATABASE [NextStream]
GO
ALTER DATABASE [NextStream] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NextStream] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NextStream] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NextStream] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NextStream] SET ARITHABORT OFF 
GO
ALTER DATABASE [NextStream] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [NextStream] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NextStream] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NextStream] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NextStream] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NextStream] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NextStream] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NextStream] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NextStream] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NextStream] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NextStream] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NextStream] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NextStream] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NextStream] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NextStream] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NextStream] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NextStream] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NextStream] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NextStream] SET  MULTI_USER 
GO
ALTER DATABASE [NextStream] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NextStream] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NextStream] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NextStream] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NextStream] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NextStream] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [NextStream] SET QUERY_STORE = ON
GO
ALTER DATABASE [NextStream] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [NextStream]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 5/12/2025 3:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 5/12/2025 3:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[ApiID] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[OriginalFilePath] [nvarchar](256) NULL,
	[ProcessedIntoStreamableFormat] [bit] NOT NULL,
	[DownloadedMovieFiles] [bit] NOT NULL,
	[Published] [datetime] NULL,
	[Creator] [nvarchar](256) NULL,
	[Subject] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieGenre]    Script Date: 5/12/2025 3:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieGenre](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MovieID] [int] NOT NULL,
	[GenreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieHistory]    Script Date: 5/12/2025 3:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieHistory](
	[ProfileID] [int] NOT NULL,
	[MovieID] [int] NOT NULL,
	[IsWatching] [bit] NOT NULL,
	[CurrentPositionInSeconds] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 5/12/2025 3:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Color] [nchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/12/2025 3:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Email] [nvarchar](512) NOT NULL,
	[PasswordHash] [nvarchar](512) NOT NULL,
 CONSTRAINT [PK__User__3214EC27E4CAA598] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 5/12/2025 3:36:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ProfileID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Genre] ON 
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (54, N'Biography')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (55, N'Drama')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (56, N'Fantasy')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (57, N'Comedy')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (58, N'Family')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (59, N'Short')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (60, N'Action')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (61, N'Romance')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (62, N'Western')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (63, N'Adventure')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (64, N'Sport')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (65, N'Horror')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (66, N'Thriller')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (67, N'Crime')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (68, N'Mystery')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (69, N'War')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (70, N'Musical')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (71, N'Sci-Fi')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (72, N'History')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (73, N'Film-Noir')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (74, N'Music')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (75, N'Animation')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (76, N'Documentary')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (77, N'Silent')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (78, N'Short film')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (79, N'Art film')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (80, N'Surrealist')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (81, N'Popular')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (82, N'Jazz')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (83, N'British History')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (84, N'ballet')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (85, N'classical')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (86, N'Game-Show')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (87, N'Interview')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (88, N'Country')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (89, N'Gospel')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (90, N'Folk, World, & Country')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (91, N'Educational')
GO
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (92, N'Science')
GO
SET IDENTITY_INSERT [dbo].[Genre] OFF
GO
SET IDENTITY_INSERT [dbo].[Movie] ON 
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1533, N'The Ten Commandments / Blu-ray / x264 / MKV / 720p / Commentary', N'ptp_the-ten-commandments_cecil-b-demille_blu-ray_x264_mkv_720p_180770', N'The first part tells the story of Moses leading the Jews from Egypt to the Promised Land, his receipt of the tablets and the worship of the golden calf. The second part shows the efficacy of the commandments in modern life through a story set in San Francisco. Two brothers, rivals for the love of Mary, also come into conflict when John discovers Dan used shoddy materials to construct a cathedral.', NULL, 1, 0, NULL, N'Jeanie Macpherson,Theodore Roberts,Cecil B. DeMille,Estelle Taylor,Julia Faye,Charles de Rochefort', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1534, N'Mush and Milk', N'MushAndMilk', N'Title: Mush and Milk<br />Summary: When Cap''s back pension finally comes in, he treats the gang to a day at an amusement park.<br />Directed by: Robert F. McGowan<br />Actors: <br />Production Company: Hal Roach Studios<br />Release Date: 27 May 1933 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   When Cap''s back pension finally comes in, he treats the gang to a day at an amusement park.</p>', NULL, 1, 0, CAST(N'1933-01-01T00:00:00.000' AS DateTime), N'Hal Roach Studios', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1535, N'The Big Trees', N'TheBigTrees720p1952', N'Title: The Big Trees<br />Summary: A Quaker colony tries to save the giant sequoias from a timber baron.<br />Directed by: Felix E. Feist<br />Actors: <br />Production Company: Warner Bros.<br />Release Date: 30 March 1952 (UK)<br />Aspect Ratio: 1.37 : 1<p></p><p>   In 1900, unscrupulous timber baron Jim Fallon plans to take advantage of a new law and make millions off California redwood. Much of the land he hopes to grab has been homesteaded by a Quaker colony, who try to persuade him to spare the giant sequoias...but these are the very trees he wants most. Expert at manipulating others, Fallon finds that other sharks are at his own heels, and forms an unlikely alliance.</p>', NULL, 1, 0, CAST(N'1952-01-01T00:00:00.000' AS DateTime), N'Warner Bros.', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1536, N'The Great Dan Patch', N'TheGreatDanPatch720p1949', N'Title: The Great Dan Patch<br />Summary: Story of the legendary trotting horse Dan Patch.<br />Directed by: Joseph M. Newman<br />Actors: <br />Production Company: W.R. Frank Productions<br />Release Date: 22 July 1949 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   David Palmer, a young chemist, returns to his father''s Indiana farm, to marry a local school teacher, Ruth Treadwell. David meets again his father''s horse-trainer, Ben Lathrop, whose daughter, Cissy, has left high school to help her father. Palmer marries and becomes wealthy through an invention, and is able to indulge his socially-ambitious wife. His father dies and Palmer returns to Indiana, where his interest in harness-racing is rekindled, as is his interest in Cissy Lathrop.</p>', NULL, 1, 0, CAST(N'1949-01-01T00:00:00.000' AS DateTime), N'W.R. Frank Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1537, N'Buckskin Frontier', N'BuckskinFrontier1943', N'Title: Buckskin Frontier<br />Summary: A railroad man and the owner of a freight line battle for control of a crucial mountain pass.<br />Directed by: Lesley Selander<br />Actors: Richard Dix, Jane Wyatt, Albert Dekker<br />Production Company: Harry Sherman Productions<br />Release Date: 14 May 1943 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Jeptha Marr has built the town of Pawnee, Kansas, and established a successful freight company. He sees his fortunes at risk due to the encroachment of a new railroad, spearheaded by Stephen Bent. Marr sends his right-hand man Gideon Skene to disrupt Bent''s activities. Bent takes an unusual tack in dealing with Marr''s opposition: he woos Marr''s daughter Vinnie. But the unscrupulous forces of a third opposing figure, the ruthless Champ Clanton, create an uneasy alliance between Bent and Marr.</p>', NULL, 1, 0, CAST(N'1943-01-01T00:00:00.000' AS DateTime), N'Harry Sherman Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1538, N'Rebecca', N'RebeccaClassic4050', N'Title: Rebecca<br />Summary: A self-conscious bride is tormented by the memory of her husband''s dead first wife.<br />Directed by: Alfred Hitchcock<br />Actors: Laurence Olivier, Joan Fontaine, George Sanders<br />Production Company: Selznick International Pictures<br />Release Date: 12 April 1940 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   A shy lady''s companion, staying in Monte Carlo with her stuffy employer, meets the wealthy Maxim de Winter. She and Max fall in love, marry and return to Manderley, his large country estate in Cornwall. Max is still troubled by the death of his first wife, Rebecca, in a boating accident the year before. The second Mrs. de Winter clashes with the housekeeper, Mrs. Danvers, and discovers that Rebecca still has a strange hold on everyone at Manderley.</p>', NULL, 1, 0, CAST(N'1940-01-01T00:00:00.000' AS DateTime), N'Selznick International Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1539, N'Africa Screams', N'AfricaScreams720p1949', N'Title: Africa Screams<br />Summary: Abbott & Costello search for diamonds in Africa, along the way meeting a visually-impaired gunner, a hungry lion, and a tribe of cannibals...<br />Directed by: Charles Barton<br />Actors: Bud Abbott, Lou Costello, Clyde Beatty<br />Production Company: Nassour Studios Inc.<br />Release Date: 27 May 1949 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   When bookseller Buzz cons Diana into thinking fellow bookseller Stanley knows a great deal about Africa they are abducted and ordered to lead Diana and her henchmen to an African tribe. After encounters with lion tamers, giant apes and a wild river, Buzz returns to America. Stanley finds diamonds and buys the store they once worked for, hiring Buzz as its elevator operator.</p>', NULL, 1, 0, CAST(N'1949-01-01T00:00:00.000' AS DateTime), N'Nassour Studios Inc.', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1540, N'Night Tide', N'NightTide1961_4', N'Title: Night Tide<br />Summary: A young sailor falls in love with a mysterious woman, performing as a mermaid at the local carnival. He soon comes to suspect the girl might be a real mermaid, who draws men to a watery death during the full moon.<br />Directed by: Curtis Harrington<br />Actors: Dennis Hopper, Linda Lawson, Gavin Muir<br />Production Company: Phoenix Films<br />Release Date: 17 September 1965 (Mexico)<br />Aspect Ratio: 1.66 : 1<p></p><p>   On leave in a shore side town, Johnny becomes interested in a young dark haired woman. They meet and he learns that she plays a mermaid in the local carnival. After strange occurrences, Johnny begins to believe that she may actually be a real mermaid that habitually kills during the cycle of the full moon.</p>', NULL, 1, 0, CAST(N'1961-01-01T00:00:00.000' AS DateTime), N'Phoenix Films', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1541, N'Gaslight', N'Gaslight_628', N'Title: Gaslight<br />Summary: Years after her aunt was murdered in her home, a young woman moves back into the house with her new husband. However, he has a secret that he will do anything to protect, even if it means driving his wife insane.<br />Directed by: George Cukor<br />Actors: Charles Boyer, Ingrid Bergman, Joseph Cotten<br />Production Company: Metro-Goldwyn-Mayer (MGM)<br />Release Date: 30 October 1944 (Sweden)<br />Aspect Ratio: 1.37 : 1<p></p><p>   After the death of her famous opera-singing aunt, Paula is sent to study in Italy to become a great opera singer as well. While there, she falls in love with the charming Gregory Anton. The two return to London, and Paula begins to notice strange goings-on: missing pictures, strange footsteps in the night and gaslights that dim without being touched. As she fights to retain her sanity, her new husband''s intentions come into question.</p>', NULL, 1, 0, CAST(N'1944-01-01T00:00:00.000' AS DateTime), N'Metro-Goldwyn-Mayer (MGM)', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1542, N'Malice in the Palace', N'MaliceInThePalace720p1949', N'Title: Malice in the Palace<br />Summary: Set in a desert land where the stooges run a restaurant, the boys set out to recover the stolen Rootin Tootin diamond after they learn from the thieves that the Emir of Shmo has absconded ...<br />Directed by: Jules White<br />Actors: Moe Howard, Larry Fine, Shemp Howard<br />Production Company: Columbia Pictures<br />Release Date: 1 September 1949 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Set in a desert land where the stooges run a restaurant, the boys set out to recover the stolen Rootin Tootin diamond after they learn from the thieves that the Emir of Shmo has absconded with the contraband jewel. They journey to the stronghold of Shmo where they disguise as Santa Clauses and scare the ruler into giving them the diamond.</p>', NULL, 1, 0, CAST(N'1949-01-01T00:00:00.000' AS DateTime), N'Columbia Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1543, N'And Then There Were None', N'attwn994545112', N'Title: And Then There Were None<br />Summary: Seven guests, a newly hired personal secretary and two staff are gathered on an isolated island by an absent host and someone begins killing them off one by one. They work together to determine who is the killer?<br />Directed by: René Clair<br />Actors: Directed by René Clair.  With Barry Fitzgerald, Walter Huston, Louis Hayward<br />Production Company: Rene Clair Productions<br />Release Date: 31 October 1945 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Seven guests, a newly hired personal secretary and two staff are gathered for a weekend on an isolated island by the hosts the Owens who are delayed. At dinner a record is played and the host''s message alleges that all the people present are guilty of murder and suddenly the first of them is dead, then the next - It seems that one of them is the murderer but the leading person is always the person who is murdered next and at last only two people are left.</p>', NULL, 1, 0, CAST(N'1945-01-01T00:00:00.000' AS DateTime), N'Rene Clair Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1544, N'The Flying Deuces', N'TheFlyingDeuces720p1939', N'Title: The Flying Deuces<br />Summary: Ollie has fallen in love with the innkeeper''s daughter in Paris. The only problem - she''s very much in love with her husband. To forget her he joins the Foreign Legion with Stan. Bad idea.<br />Directed by: A. Edward Sutherland<br />Actors: <br />Production Company: RKO Radio Pictures<br />Release Date: 3 November 1939 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Oliver is heartbroken when he finds that Georgette, the inkeeper''s daughter he''s fallen in love with, is already married to dashing Foreign Legion officer Francois. To forget her, he joins the Legion, taking Stanley with him. Their bumbling eventually gets them charged with desertion and sentenced to a firing squad. They manage to escape in a stolen airplane, but crash after a wild ride.</p>', NULL, 1, 0, CAST(N'1939-01-01T00:00:00.000' AS DateTime), N'RKO Radio Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1545, N'The Green Glove', N'TheGreenGlove720p1952', N'Title: The Green Glove<br />Summary: An ex-soldier and his new girlfriend comb France for a valuable relic...which others are willing to kill for.<br />Directed by: Rudolph Maté<br />Actors: Directed by Rudolph Maté.  With Glenn Ford, Geraldine Brooks, Cedric Hardwicke<br />Production Company: Benagoss Productions<br />Release Date: 28 February 1952 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   In World War II France, American soldier Michael Blake captures, then loses Nazi-collaborator art thief Paul Rona, who leaves behind a gem studded gauntlet (a stolen religious relic). Years later, financial reverses lead Mike to return in search of the object. In Paris, he must dodge mysterious followers and a corpse that''s hard to explain; so he and attractive tour guide Christine decamp on a cross-country pursuit that becomes love on the run...then takes yet another turn.</p>', NULL, 1, 0, CAST(N'1952-01-01T00:00:00.000' AS DateTime), N'Benagoss Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1546, N'Dick Tracy vs. Cueball', N'DickTracyVsCueball720p1946', N'Title: Dick Tracy vs. Cueball<br />Summary: Expensive diamonds are stolen but before the thief can fence them he is strangled by ex-con Cueball, who then takes the gems and continues murdering people he believes are trying to swindle...<br />Directed by: Gordon Douglas<br />Actors: Morgan Conway, Anne Jeffreys, Lyle Latell<br />Production Company: RKO Radio Pictures<br />Release Date: 18 December 1946 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Expensive diamonds are stolen but before the thief can fence them he is strangled by ex-con Cueball, who then takes the gems and continues murdering people he believes are trying to swindle him. Dick Tracy allows his girlfriend Tess to act as a buyer for the gems but his plan backfires when she is captured by the homicidal Cueball.</p>', NULL, 1, 0, CAST(N'1946-01-01T00:00:00.000' AS DateTime), N'RKO Radio Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1547, N'International Crime', N'InternationalCrime1938', N'Title: International Crime<br />Summary: Lamont Cranston (<a href="/name/nm0478942/?ref_=" rel="nofollow">Rod La Rocque</a>), amateur criminologist and detective, with a daily radio program, sponsored by the Daily Classic newspaper, has developed a friendly feud that sometimes ...<br />Directed by: Charles Lamont<br />Actors: Rod La Rocque, Astrid Allwyn, Thomas E. Jackson<br />Production Company: M & A Alexander Productions Inc.<br />Release Date: 23 April 1938 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Lamont Cranston (</p>', NULL, 1, 0, CAST(N'1938-01-01T00:00:00.000' AS DateTime), N'M & A Alexander Productions Inc.', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1548, N'Boarding House Blues', N'BoardingHouseBlues1948', N'Title: Boarding House Blues<br />Summary: Tenants of a Harlem boarding house put on a show to save their home.<br />Directed by: Josh Binney<br />Actors: Moms Mabley, Dusty Fletcher, Marcellus Wilson<br />Production Company: All-American News<br />Release Date: September 1948 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Despite the slapstick atmosphere there, the inhabitants of Moms'' theatrical boarding house in Harlem are broke and in danger of losing their home. For some ready cash, they trick a producer into helping them put on a show, featuring a variety of black specialty acts.</p>', NULL, 1, 0, CAST(N'1948-01-01T00:00:00.000' AS DateTime), N'All-American News', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1549, N'The Scarlet Pimpernel', N'TheScarletPimpernel720p1934', N'Title: The Scarlet Pimpernel<br />Summary: A noblewoman discovers her husband is The Scarlet Pimpernel, a vigilante who rescues aristocrats from the blade of the guillotine.<br />Directed by: Harold Young<br />Actors: Leslie Howard, Merle Oberon, Raymond Massey<br />Production Company: London Film Productions<br />Release Date: 7 February 1935 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   London fop Percy Blakeney is also secretly the Scarlet Pimpernel who, in a variety of disguises, makes repeated daring trips to France to save aristocrats from Madame Guillotine. His unknowing wife is also French, and she finds that her brother has been arrested by the Republic to try and get her to find out who "that damned elusive Pimpernel" really is.</p>', NULL, 1, 0, CAST(N'1934-01-01T00:00:00.000' AS DateTime), N'London Film Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1550, N'The Phantom Planet', N'PhantomPlanet_286', N'Title: The Phantom Planet<br />Summary: After an invisible asteroid draws an astronaut and his ship to its surface, he is miniaturized by the phantom planet''s exotic atmosphere.<br />Directed by: William Marshall<br />Actors: Dean Fredericks, Coleen Gray, Anthony Dexter<br />Production Company: Four Crown Productions Inc.<br />Release Date: 13 December 1961 (USA)<br />Aspect Ratio: 1.85 : 1<p></p><p>   The mysterious appearance of an unknown planet brings miniature people, giant monsters, beautiful women and undaunted heroes to the screen. The self-contained planet "Rheton" has the ability to move in and out of galaxies to escape their enemies. Earth sends an astronaut team to investigate, which discovers miniature people. One astronaut survives to help them fight off monsters and Solorite attacks.</p>', NULL, 1, 0, CAST(N'1961-01-01T00:00:00.000' AS DateTime), N'Four Crown Productions Inc.', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1551, N'Mr. Wong, Detective', N'Mr.WongDetective720p1938', N'Title: Mr. Wong, Detective<br />Summary: When a chemical manufacturer is killed after asking detective James Wong to help him, Wong investigates this and two subsequent murders. He uncovers a international spy ring hoping to steal...<br />Directed by: William Nigh<br />Actors: Boris Karloff, Grant Withers, Maxine Jennings<br />Production Company: Monogram Pictures<br />Release Date: 5 October 1938 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   When a chemical manufacturer is killed after asking detective James Wong to help him, Wong investigates this and two subsequent murders. He uncovers a international spy ring hoping to steal the formula for a poison gas being developed by the first victim''s company.</p>', NULL, 1, 0, CAST(N'1938-01-01T00:00:00.000' AS DateTime), N'Monogram Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1552, N'The Song of Bernadette', N'TheSongOfBernadette1943', N'Title: The Song of Bernadette<br />Summary: In 1858 France, Bernadette, an adolescent peasant girl, has a vision of "a beautiful lady" in the city dump. She never claims it to be anything other than this, but the townspeople all ...<br />Directed by: Henry King<br />Actors: Jennifer Jones, Charles Bickford, William Eythe<br />Production Company: Twentieth Century Fox<br />Release Date: April 1945 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   In 1858 France, Bernadette, an adolescent peasant girl, has a vision of "a beautiful lady" in the city dump. She never claims it to be anything other than this, but the townspeople all assume it to be the virgin Mary. The pompous government officials think she is nuts, and do their best to suppress the girl and her followers, and the church wants nothing to do with the whole matter. But as Bernadette attracts wider and wider attention, the phenomenon overtakes everyone in the town, and transforms their lives.</p>', NULL, 1, 0, CAST(N'1943-01-01T00:00:00.000' AS DateTime), N'Twentieth Century Fox', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1553, N'The Wrong Road', N'WrongRoad', N'Title: The Wrong Road<br />Summary: A young unmarried couple whose plans for their life together haven''t turned out as expected decide to rob the bank where the husband works of $100,000, then hide the money in a safe place ...<br />Directed by: James Cruze<br />Actors: Richard Cromwell, Helen Mack, Lionel Atwill<br />Production Company: Republic Pictures (I)<br />Release Date: 11 October 1937 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   A young unmarried couple whose plans for their life together haven''t turned out as expected decide to rob the bank where the husband works of $100,000, then hide the money in a safe place and return for it after they serve out their sentences. All goes according to plan until they get out of prison, when they find that they''re being trailed by an insurance investigator and the husband''s old cellmate, who has decided that he wants a cut of the money.</p>', NULL, 1, 0, CAST(N'1937-01-01T00:00:00.000' AS DateTime), N'Republic Pictures (I)', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1554, N'The Hanged Man', N'TheHangedMan', N'Title: The Hanged Man<br />Summary: Miraculously still alive after his hanging, gunfighter James Devlin defends a young widow''s farm from a vicious land grabber.<br />Directed by: Michael Caffey<br />Actors: Steve Forrest, Dean Jagger, Will Geer<br />Production Company: Andrew J. Fenady Productions<br />Release Date: TV Movie 13 March 1974<br />Aspect Ratio: 1.33 : 1<p></p><p>   A gunfighter who survives his own hanging helps a young widow who is trying to keep a ruthless land baron from taking her ranch.</p>', NULL, 1, 0, CAST(N'1974-01-01T00:00:00.000' AS DateTime), N'Andrew J. Fenady Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1555, N'Salt of the Earth', N'SaltOfTheEarth_735', N'Title: Salt of the Earth<br />Summary: Mexican workers at a Zinc mine call a general strike. It is only through the solidarity of the workers, and importantly the indomitable resolve of their wives, mothers and daughters, that they eventually triumph.<br />Directed by: Herbert J. Biberman<br />Actors: <br />Production Company: Independent Productions<br />Release Date: 14 March 1954 (USA)<br />Aspect Ratio: 1.33 : 1<p></p><p>   Based on an actual strike against the Empire Zinc Mine in New Mexico, the film deals with the prejudice against the Mexican-American workers, who struck to attain wage parity with Anglo workers in other mines and to be treated with dignity by the bosses. In the end, the greatest victory for the workers and their families is the realization that prejudice and poor treatment are conditions that are not always imposed by outside forces.</p>', NULL, 1, 0, CAST(N'1954-01-01T00:00:00.000' AS DateTime), N'Independent Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1556, N'That Gang of Mine', N'ThatGangOfMine720p1940', N'Title: That Gang of Mine<br />Summary: A street kid has dreams of becoming a jockey. He gets his chance when he and his gang discover a poor old man who has a championship race horse. The man agrees to let the boy ride his horse...<br />Directed by: Joseph H. Lewis<br />Actors: <br />Production Company: Banner Productions<br />Release Date: 23 September 1940 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   A street kid has dreams of becoming a jockey. He gets his chance when he and his gang discover a poor old man who has a championship race horse. The man agrees to let the boy ride his horse in a race, but first the gang must get enough money to pay for the race''s entry fees.</p>', NULL, 1, 0, CAST(N'1940-01-01T00:00:00.000' AS DateTime), N'Banner Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1557, N'A Fool There Was', N'AFoolThereWas1915', N'Title: A Fool There Was<br />Summary: A married diplomat falls hopelessly under the spell of a predatory woman.<br />Directed by: Frank Powell<br />Actors: Runa Hodges, Mabel Frenyear, Edward José<br />Production Company: Fox Film Corporation<br />Release Date: 12 January 1915 (USA)<br />Aspect Ratio: 1.33 : 1<br />Color: Black and White<p></p><p>   John Schuyler, happily married Wall Street lawyer, is appointed as special diplomatic representative to England. By an unhappy accident, his wife and child can''t come along; but on the ship with him is "The Vampire," a "notorious woman" who lives off a succession of men she has seduced and ruined. Slighted by Mrs. Schuyler, she has set her sights on the husband. Two months later, we find the Fool languishing with the mistress who has him enmeshed in her toils. Will he follow the others to the depths of degradation?</p>', NULL, 1, 0, CAST(N'1915-01-01T00:00:00.000' AS DateTime), N'Fox Film Corporation', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1558, N'Murder at the Baskervilles', N'MurderAtTheBaskervilles720p1937', N'Title: Murder at the Baskervilles<br />Summary: Sherlock Holmes takes a vacation and visits his old friend Sir Henry Baskerville. His vacation ends when he suddenly finds himself in the middle of a double-murder mystery. Now he''s got to ...<br />Directed by: Thomas Bentley<br />Actors: Arthur Wontner, Ian Fleming, Lyn Harding<br />Production Company: Julius Hagen Productions<br />Release Date: 15 January 1941 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Sherlock Holmes takes a vacation and visits his old friend Sir Henry Baskerville. His vacation ends when he suddenly finds himself in the middle of a double-murder mystery. Now he''s got to find Professor Moriarty and the horse Silver Blaze before the great cup final horse race.</p>', NULL, 1, 0, CAST(N'1937-01-01T00:00:00.000' AS DateTime), N'Julius Hagen Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1559, N'The Human Monster', N'TheHumanMonster720p1939', N'Title: The Human Monster<br />Summary: Insurance agent-physician collects on policies of men murdered by a disfigured resident of the home for the blind where he acts as doctor-on-call.<br />Directed by: Walter Summers<br />Actors: Bela Lugosi, Hugh Williams, Greta Gynt<br />Production Company: John Argyle Productions<br />Release Date: 24 March 1940 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   A series of strange deaths takes place in London. All are accidents but the victims are single men with no family and they all have a link to a life insurance company run by the mysterious Dr. Orloff.</p>', NULL, 1, 0, CAST(N'1939-01-01T00:00:00.000' AS DateTime), N'John Argyle Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1560, N'The Best Years of Our Lives', N'tbyool435345435110', N'Title: The Best Years of Our Lives<br />Summary: Three World War II veterans return home to small-town America to discover that they and their families have been irreparably changed.<br />Directed by: William Wyler<br />Actors: Myrna Loy, Dana Andrews, Fredric March<br />Production Company: The Samuel Goldwyn Company<br />Release Date: 29 May 1947 (Mexico)<br />Aspect Ratio: 1.37 : 1<p></p><p>   The story concentrates on the social re-adjustment of three World War II servicemen, each from a different station of society. Al Stephenson returns to an influential banking position, but finds it hard to reconcile his loyalties to ex-servicemen with new commercial realities. Fred Derry is an ordinary working man who finds it difficult to hold down a job or pick up the threads of his marriage. Having had both hands burnt off during the war, Homer Parrish is unsure that his fiancée''s feelings are still those of love and not those of pity. Each of the veterans faces a crisis upon his arrival, and each crisis is a microcosm of the experiences of many American warriors who found an alien world awaiting them when they came marching home.</p>', NULL, 1, 0, CAST(N'1946-01-01T00:00:00.000' AS DateTime), N'The Samuel Goldwyn Company', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1561, N'Miss Lulu Bett', N'MissLuluBett1921', N'Title: Miss Lulu Bett<br />Summary: A once-timid young woman gains newfound confidence after a failed marriage, much to the chagrin of her miserable family.<br />Directed by: William C. de Mille<br />Actors: <br />Production Company: Paramount Pictures<br />Release Date: November 1921 (USA)<br />Aspect Ratio: 1.33 : 1<p></p><p>   Wlliam deMille produced and directed Miss Lulu Bett, a film of extraordinary conviction and insight. It was then often the custom for unmarried women to lodge with family; thus we discover Miss Lulu in a boring Midwestern town, an exploited household drudge for her sister and her overbearing brother-in-law. In the course of the story (based upon the Pulitzer Prize play and novel by Zona Gale), Lulu evolves from slavery into an attractive and self-assured woman, prepared to make her own life. Revealed through wonderful performances and clever use of props, the characters are extraordinarily solid and involving.</p>', NULL, 1, 0, CAST(N'1921-01-01T00:00:00.000' AS DateTime), N'Paramount Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1562, N'The Ghost', N'TheGhost720p', N'Title: The Ghost<br />Summary: A woman and her lover murder her husband, a doctor. Soon, however, strange things start happening, and they wonder if they really killed him, or if he is coming back from the dead to haunt them.<br />Directed by: Riccardo Freda<br />Actors: Barbara Steele, Peter Baldwin, Elio Jotta<br />Production Company: Panda Societa per L''Industria Cinematografica<br />Release Date: 30 March 1963 (Italy)<br />Aspect Ratio: 1.85 : 1<p></p><p>   A woman and her lover murder her husband, a doctor. Soon, however, strange things start happening, and they wonder if they really killed him, or if he is coming back from the dead to haunt them.</p>', NULL, 1, 0, CAST(N'1963-01-01T00:00:00.000' AS DateTime), N'Panda Societa per L''Industria Cinematografica', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1563, N'They Meet Again', N'TheyMeetAgain', N'Title: They Meet Again<br />Summary: In the sixth entry of this series, Dr. Paul Christian is giving a party for Janie Webster, a motherless little girl of nine, with a fine singing voice. But, as her father, Bob Webster, is ...<br />Directed by: Erle C. Kenton<br />Actors: <br />Production Company: Stephens-Lang Productions<br />Release Date: 11 July 1941 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   In the sixth entry of this series, Dr. Paul Christian is giving a party for Janie Webster, a motherless little girl of nine, with a fine singing voice. But, as her father, Bob Webster, is about to leave the bank where he works to go to the celebration, a shortage is found in his books. for which he is held responsible, jailed, and subsequently, in a court trial is found guilty. Janie is not told that her father is going to prison, but her South Park schoolmates quickly make sure she is informed and brought up to date, and she becomes very ill. Dr. Christian gets his friends and household together, especially Mr. Hastings, his housekeeper who solves all problems by astrology, and, based on a hunch by Dr. Christian, who is convinced Bob is not guilty, they decide to ''cherchez la femme" (not easy to do with a Swedish accent) and prove Bob''s innocence. And do so just in time to watch Janie win the state-wide singing contest.</p>', NULL, 1, 0, CAST(N'1941-01-01T00:00:00.000' AS DateTime), N'Stephens-Lang Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1564, N'Hour of Glory', N'SmallBackRoom_4980', N'Title: Hour of Glory<br />Summary: As the Germans drop explosive booby-traps on Britain in 1943, the embittered expert who''ll have to disarm them fights a private battle with alcohol.<br />Directed by: Michael Powell, Emeric Pressburger<br />Actors: <br />Production Company: The Archers<br />Release Date: 23 February 1952 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   The best bomb disposal officer during World War II was badly injured and is in frequent pain. He finds solace and relief from his pain in the whisky bottle & the pills that are never far away. A new type of booby trapped bomb push his nerves & resolution to the limit.</p>', NULL, 1, 0, CAST(N'1949-01-01T00:00:00.000' AS DateTime), N'The Archers', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1565, N'The Son of Monte Cristo', N'TheSonOfMonteCristo720p1940', N'Title: The Son of Monte Cristo<br />Summary: In 1865, General Gurko Lanen is dictator of "Lichtenburg" in the Balkans. Rightful ruler Zona hopes to get aid from Napoleon III of France. The visiting Count of Monte Cristo falls for Zona...<br />Directed by: Rowland V. Lee<br />Actors: <br />Production Company: Edward Small Productions<br />Release Date: 10 January 1941 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   In 1865, General Gurko Lanen is dictator of "Lichtenburg" in the Balkans. Rightful ruler Zona hopes to get aid from Napoleon III of France. The visiting Count of Monte Cristo falls for Zona and undertakes to help her, masquerading as a foppish banker and a masked freedom fighter. The rest is rapid-fire intrigue and derring-do.</p>', NULL, 1, 0, CAST(N'1940-01-01T00:00:00.000' AS DateTime), N'Edward Small Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1566, N'Indiscretion of an American Wife', N'AnAmericanWife', N'Title: Indiscretion of an American Wife<br />Summary: Prior to leaving by train for Paris, a married American woman tries to break off her affair with a young Italian in Rome''s Stazione Termini.<br />Directed by: Vittorio De Sica<br />Actors: Jennifer Jones, Montgomery Clift, Gino Cervi<br />Production Company: Columbia Pictures Corporation<br />Release Date: 10 May 1954 (USA)<br />Aspect Ratio: 1.37 : 1<br />Color: Black and White<p></p><p>   A married American woman has gotten involved with another man while visiting relatives in Rome. She decides that the time has come to break off the relationship, and she makes plans to return home to her husband. But she soon realizes that she is not at all sure about what she wants to do, and she continues to agonize over her decision.</p>', NULL, 1, 0, CAST(N'1953-01-01T00:00:00.000' AS DateTime), N'Columbia Pictures Corporation', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1567, N'White Zombie', N'WhiteZombie720p1932', N'Title: White Zombie<br />Summary: A young man turns to a witch doctor to lure the woman he loves away from her fiancé, but instead turns her into a zombie slave.<br />Directed by: Victor Halperin<br />Actors: Bela Lugosi, Madge Bellamy, Joseph Cawthorn<br />Production Company: Victor & Edward Halperin Productions<br />Release Date: 4 August 1932 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Young couple Madeleine and Neil are coaxed by acquaintance Monsieur Beaumont to get married on his Haitian plantation. Beaumont''s motives are purely selfish as he makes every attempt to convince the beautiful young girl to run away with him. For help Beaumont turns to the devious Legendre, a man who runs his mill by mind controlling people he has turned into zombies. After Beaumont uses Legendre''s zombie potion on Madeleine, he is dissatisfied with her emotionless being and wants her to be changed back. Legendre has no intention of doing this and he drugs Beaumont as well to add to his zombie collection. Meanwhile, grieving ''widower'' Neil is convinced by a local priest that Madeleine may still be alive and he seeks her out.</p>', NULL, 1, 0, CAST(N'1932-01-01T00:00:00.000' AS DateTime), N'Victor & Edward Halperin Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1568, N'Eyes in the Night', N'EyesInTheNight720p1942', N'Title: Eyes in the Night<br />Summary: A blind detective and his seeing-eye dog investigate a murder and discover a Nazi plot.<br />Directed by: Fred Zinnemann<br />Actors: Edward Arnold, Ann Harding, Donna Reed<br />Production Company: Metro-Goldwyn-Mayer (MGM)<br />Release Date: 29 April 1943 (Mexico)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Blind detective Duncan Maclain is visited by old friend Norma Lawry, looking for help in getting rid of one of her old beaus, who is courting Norma''s 17-year old step-daughter. When the old beau is found murdered, Norma is the chief suspect until Duncan (aided by his guide-dog Friday) pays a visit to her home and uncovers a plot to steal her husband''s military secrets for the enemy.</p>', NULL, 1, 0, CAST(N'1942-01-01T00:00:00.000' AS DateTime), N'Metro-Goldwyn-Mayer (MGM)', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1569, N'The Deadly Companions', N'tdc1104552', N'Title: The Deadly Companions<br />Summary: An ex-army officer accidentally kills a woman''s son and tries to make up for it by escorting the funeral procession through dangerous Indian territory.<br />Directed by: Sam Peckinpah<br />Actors: <br />Production Company: Pathé America<br />Release Date: 16 February 1962 (Sweden)<br />Aspect Ratio: 2.35 : 1<p></p><p>   The Civil War Yankee sergeant Yellowleg saves the cheater Turkey from hanging after a card game, and together with Turk''s gunslinger buddy Billy Keplinger, they ride together to Gila City with the intention of heisting a bank. When other bandits rob a store, Yellowleg shoots at the outlaws and accidentally kills the son of the cabaret dancer Kit Tilden and the grieving woman decides to bury her son in the town of Siringo in Apache country where her husband is buried. Yellowleg Enlists Billy and Turkey to escort Kitty and the coffin through the dangerous land.</p>', NULL, 1, 0, CAST(N'1961-01-01T00:00:00.000' AS DateTime), N'Pathé America', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1570, N'Chamber of Horrors', N'ChamberOfHorrors', N'Title: Chamber of Horrors<br />Summary: A murder is found to be connected to a false heir and a secret underground torture chamber.<br />Directed by: Norman Lee<br />Actors: Leslie Banks, Lilli Palmer, Romilly Lunge<br />Production Company: Rialto Productions<br />Release Date: 20 December 1940 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   A murder is found to be connected to a false heir and a secret underground torture chamber.</p>', NULL, 1, 0, CAST(N'1940-01-01T00:00:00.000' AS DateTime), N'Rialto Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1571, N'Beyond Tomorrow', N'BeyondTomorrow_750', N'Title: Beyond Tomorrow<br />Summary: The ghosts of three elderly industrialists killed in an airplane crash return to Earth to help reunite a young couple whom they initially brought together.<br />Directed by: A. Edward Sutherland<br />Actors: <br />Production Company: Academy Productions<br />Release Date: 10 May 1940 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Melton, Chadwick and O''Brien, rich but lonely heads of an engineering firm, invite three strangers to dinner on Christmas Eve. Only two show up, James and Jean, they fall in love and become friends with their three benefactors...until the latter are killed in a plane crash and come back to their old home as ghosts. In the coming months, true love encounters some rough spots; can ghostly O''Brien help the young folks?</p>', NULL, 1, 0, CAST(N'1940-01-01T00:00:00.000' AS DateTime), N'Academy Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1572, N'He Walked by Night', N'HeWalkedByNight720p1948', N'Title: He Walked by Night<br />Summary: This film-noir piece, told in semi-documentary style, follows police on the hunt for a resourceful criminal who shoots and kills a cop.<br />Directed by: Alfred L. Werker, Anthony Mann<br />Actors: <br />Production Company: Bryan Foy Productions<br />Release Date: 10 May 1949 (Argentina)<br />Aspect Ratio: 1.37 : 1<p></p><p>   In the Post-World War II, in Los Angeles, a criminal shoots and kills a police officer in the middle of the night. Without any leads, the chief of the LAPD assigns Sgt. Chuck Jones and Sgt. Marty Brennan to investigate the murder and apprehend the culprits. When the dealer of electronics devices, Paul Reeves, is caught selling a stolen projector, the police identifies the criminal, and connects him to other unsolved robberies. Using the witnesses of his heists, they draw their face, but the true identity of the smart and intelligent criminal is not disclosed. The perseverance of Sgt. Marty Brennan in his investigation gives a clue where he might live.</p>', NULL, 1, 0, CAST(N'1948-01-01T00:00:00.000' AS DateTime), N'Bryan Foy Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1573, N'The General', N'TheGeneral720p1926', N'Title: The General<br />Summary: When Union spies steal an engineer''s beloved locomotive, he pursues it single-handedly and straight through enemy lines.<br />Directed by: Clyde Bruckman, Buster Keaton<br />Actors: <br />Production Company: Buster Keaton Productions<br />Release Date: 24 February 1927 (France)<br />Aspect Ratio: 1.33 : 1<p></p><p>   Johnnie loves his train ("The General") and Annabelle Lee. When the Civil War begins he is turned down for service because he''s more valuable as an engineer. Annabelle thinks it''s because he''s a coward. Union spies capture The General with Annabelle on board. Johnnie must rescue both his loves.</p>', NULL, 1, 0, CAST(N'1926-01-01T00:00:00.000' AS DateTime), N'Buster Keaton Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1574, N'Devil Girl from Mars', N'DevilGirlFromMars', N'Title: Devil Girl from Mars<br />Summary: An uptight, leather-clad female alien, armed with a ray gun and accompanied by a menacing robot, comes to Earth to collect Earth''s men as breeding stock.<br />Directed by: David MacDonald<br />Actors: Hugh McDermott, Hazel Court, Peter Reynolds<br />Production Company: Danziger Productions Ltd.<br />Release Date: 27 April 1955 (USA)<br />Aspect Ratio: 1.80 : 1<p></p><p>   In a Scottish inn, the owners, employees and guests are reunited in the bar. Our of the blue, a flying saucer lands nearby and a woman dressed in black leather like a dominatrix with a cape arrives in the bar armed with a ray-gun. She explains that she is Nyah from Mars, and she was heading to London. However her spacecraft collided with an airplane and was damaged; therefore she had to land to repair the saucer. She also explains that she is looking for men to breed her female race since the male population is dying after warfare between males and females and they need offspring. Nyah has the robot Chani to help her to capture men, but she wants that one of the men volunteers to go with her to Mars. Who might be the volunteer?</p>', NULL, 1, 0, CAST(N'1954-01-01T00:00:00.000' AS DateTime), N'Danziger Productions Ltd.', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1575, N'The Man on the Eiffel Tower', N'TheManOnTheEiffelTower720p1949', N'Title: The Man on the Eiffel Tower<br />Summary: French police inspector Maigret investigates the murder of a rich Paris widow and ends up chasing the killer up the Eiffel Tower''s girders.<br />Directed by: Burgess Meredith, Irving Allen, Charles Laughton<br />Actors: <br />Production Company: A&T Film Production (Allen-Tone)<br />Release Date: 4 February 1950 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   In Paris, a down and out medical student Johann Radek (Franchot Tone) is paid by Bill Kirby (Robert Hutton) to murder his wealthy aunt. A knife grinder (Burgess Meredith) is suspected, but Radek keeps taunting the police until they realize that he is the killer. The police and Maigret (Charles Laughton) are led on chases through the streets and over the rooftops of Paris and finally up the girders of the Eiffel Tower.</p>', NULL, 0, 0, CAST(N'1949-01-01T00:00:00.000' AS DateTime), N'A&T Film Production (Allen-Tone)', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1576, N'My Favorite Brunette', N'MyFavoriteBrunette720p1947', N'Title: My Favorite Brunette<br />Summary: Shortly before his execution on the death row in San Quentin, amateur sleuth and baby photographer Ronnie Jackson, tells reporters how he got there.<br />Directed by: Elliott Nugent<br />Actors: Bob Hope, Dorothy Lamour, Peter Lorre<br />Production Company: Hope Enterprises<br />Release Date: 4 April 1947 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Baby photographer Ronnie Jackson, on death row in San Quentin, tells reporters how he got there: taking care of his private-eye neighbor''s office, Ronnie is asked by the irresistible Baroness Montay to find the missing Baron. There follow confusing but sinister doings in a gloomy mansion and a private sanatorium, with every plot twist a parody of thriller cliches. What are the villains really after? Can Ronnie beat a framed murder rap?</p>', NULL, 1, 0, CAST(N'1947-01-01T00:00:00.000' AS DateTime), N'Hope Enterprises', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1577, N'&quot;The Wednesday Play&quot; Cathy Come Home', N'CathyComeHome', N'Title: "The Wednesday Play" Cathy Come Home<br />Summary: Cathy loses her home, husband and eventually her child through the inflexibility of the British welfare system.<br />Directed by: Ken Loach<br />Actors: Carol White, Ray Brooks, Winifred Dennis<br />Production Company: British Broadcasting Corporation (BBC)<br />Release Date: Episode aired 28 March 1969<br />Aspect Ratio: 1.33 : 1<p></p><p>   Cathy loses her home, husband and eventually her child through the inflexibility of the British welfare system.</p>', NULL, 1, 0, CAST(N'1966-01-01T00:00:00.000' AS DateTime), N'British Broadcasting Corporation (BBC)', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1578, N'Repulsion', N'pagkasuklam', N'Title: Repulsion<br />Summary: A sex-repulsed woman who disapproves of her sister''s boyfriend sinks into depression and has horrific visions of rape and violence.<br />Directed by: Roman Polanski<br />Actors: Catherine Deneuve, Ian Hendry, John Fraser<br />Production Company: Compton Films<br />Release Date: 3 October 1965 (USA)<br />Aspect Ratio: 1.66 : 1<p></p><p>   In London, Belgian immigrant Carol Ledoux shares an apartment with her older sister Helen, and works as a manicurist at a beauty salon. Helen uses the word "sensitive" to describe Carol''s overall demeanor, which is almost like she walks around in a daze, rarely speaking up about anything. When she does speak up, it generally is about something against one of those few issues on which she obsesses, such as Helen''s boyfriend Michael''s invasion of her space at the apartment. That specific issue may be more about men in general than just Michael''s actions, as witnessed by Carol being agitated by hearing Helen and Michael''s lovemaking, and she not being able to rebuff the advances effectively of a male suitor, Colin, who is infatuated with her. One of those other obsessive issues is noticing cracks and always wanting to fix them. While Helen and Michael leave on a vacation to Pisa, Italy, Carol chooses largely to lock herself in the apartment, ditching work. There, she is almost hypnotized...</p>', NULL, 1, 0, CAST(N'1965-01-01T00:00:00.000' AS DateTime), N'Compton Films', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1579, N'Malta Story', N'MaltaStory', N'Title: Malta Story<br />Summary: In World War II, the island of Malta, strategically located and vital to supply lines in the Mediterranean Sea, is fiercely attacked by the Germans, but staunchly defended by the British.<br />Directed by: Brian Desmond Hurst<br />Actors: Alec Guinness, Jack Hawkins, Anthony Steel<br />Production Company: J. Arthur Rank Organisation<br />Release Date: 5 August 1954 (USA)<br />Aspect Ratio: 1.66 : 1<p></p><p>   In 1942, Britain was clinging to the island of Malta since it was critical to keeping Allied supply lines open. The Axis also wanted it for their own supply lines. Plenty of realistic reenactments and archival combat footage as the British are beseiged and try to fight off the Luftwaffe. Against this background, a Royal Air Force reconnaissance photographer''s romance with a local girl is endangered as he tries to plot enemy movements.</p>', NULL, 1, 0, CAST(N'1953-01-01T00:00:00.000' AS DateTime), N'J. Arthur Rank Organisation', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1580, N'Our Town', N'OurTown720p1940', N'Title: Our Town<br />Summary: Change comes slowly to a small New Hampshire town in the early 20th century.<br />Directed by: Sam Wood<br />Actors: William Holden, Martha Scott, Fay Bainter<br />Production Company: Sol Lesser Productions<br />Release Date: 24 May 1940 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Change comes slowly to a small New Hampshire town in the early 20th century. People grow up, get married, live, and die. Milk and the newspaper get delivered every morning, and nobody locks their front doors.</p>', NULL, 1, 0, CAST(N'1940-01-01T00:00:00.000' AS DateTime), N'Sol Lesser Productions', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1581, N'&quot;Bonanza&quot; The Abduction', N'bta45465468813', N'Title: "Bonanza" The Abduction<br />Summary: Jennifer Beale is abducted in the hopes her rich father, Joshua, the richest silver baron on the Comstock, will pay a $1M ransom. The plan unravels when the beautiful Della is killed and Hercules, who loves her, finds out who did it.<br />Directed by: Charles F. Haas<br />Actors: <br />Production Company: National Broadcasting Company (NBC)<br />Release Date: Episode aired 29 October 1960<br />Aspect Ratio: 1.33 : 1<p></p><p>   Jennifer Beale is abducted in the hopes her rich father, Joshua, the richest silver baron on the Comstock, will pay a $1M ransom. The plan unravels when the beautiful Della is killed and Hercules, who loves her, finds out who did it.</p>', NULL, 1, 0, CAST(N'1960-01-01T00:00:00.000' AS DateTime), N'National Broadcasting Company (NBC)', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1582, N'The Day the Earth Caught Fire', N'TheDayTheEarthCaughtFire1961', N'Title: The Day the Earth Caught Fire<br />Summary: When the U.S. and Russia unwittingly test atomic bombs at the same time, it alters the nutation (axis of rotation) of the Earth.<br />Directed by: Val Guest<br />Actors: Edward Judd, Janet Munro, Leo McKern<br />Production Company: Pax Films<br />Release Date: May 1962 (USA)<br />Aspect Ratio: 2.35 : 1<p></p><p>   Hysterical panic has engulfed the world after the United States and the Soviet Union simultaneously detonate nuclear devices causing a change to the nutation (axis of rotation) of the Earth.</p>', NULL, 1, 0, CAST(N'1961-01-01T00:00:00.000' AS DateTime), N'Pax Films', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1583, N'The Canary Murder Case', N'CanaryMurderCase', N'Title: The Canary Murder Case<br />Summary: A beautiful showgirl, nicknamed ''the Canary'', is a scheming nightclub singer. Blackmailing is her game and soon ends up dead. But who killed ''the Canary''. All the suspects who knew her had ...<br />Directed by: Malcolm St. Clair, Frank Tuttle<br />Actors: <br />Production Company: Paramount Pictures<br />Release Date: 1929 (Germany)<br />Aspect Ratio: 1.20 : 1<p></p><p>   A beautiful showgirl, nicknamed ''the Canary'', is a scheming nightclub singer. Blackmailing is her game and soon ends up dead. But who killed ''the Canary''. All the suspects who knew her had been used by her. The only witness to the crime was also killed. Only one man, debonair detective, Philo Vance, might be able to figure out who silenced ''the Canary''.</p>', NULL, 1, 0, CAST(N'1929-01-01T00:00:00.000' AS DateTime), N'Paramount Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1584, N'An Inspector Calls', N'AnInspectorCalls1954_201508', N'Title: An Inspector Calls<br />Summary: When a young girl is found dead an inspector is sent to investigate a prosperous Yorkshire household. It emerges that each member of the family has a guilty secret - each one is partly responsible for her death.<br />Directed by: Guy Hamilton<br />Actors: Alastair Sim, Arthur Young, Olga Lindo<br />Production Company: British Lion Film Corporation<br />Release Date: 18 March 1955 (France)<br />Aspect Ratio: 1.37 : 1<br />Color: Black and White<p></p><p>   Set in 1912, an upper crust English family''s dinner is interrupted when a police inspector brings news of a girl known to everyone present having died in suspicious circumstances. It seems each member of the family could have had a hand in her death. But who is the mysterious Inspector and what can he want of them? This was originally a West End play.</p>', NULL, 1, 0, CAST(N'1954-01-01T00:00:00.000' AS DateTime), N'British Lion Film Corporation', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1585, N'Kingdom of the Spiders', N'KingdomOfSpiders', N'Title: Kingdom of the Spiders<br />Summary: In rural Arizona, countless killer tarantulas are migrating through a farm town, killing every living thing in their path. The town''s veterinarian will do everything in his power to survive the onslaught.<br />Directed by: John ''Bud'' Cardos<br />Actors: <br />Production Company: Arachnid Productions Ltd.<br />Release Date: November 1977 (USA)<br />Aspect Ratio: 1.85 : 1<p></p><p>   Investigating the mysterious deaths of a number of farm animals, vet Rack Hansen discovers that his town lies in the path of hoards of migrating tarantulas. Before he can take action, the streets are overrun by killer spiders, trapping a small group of towns folk in a remote hotel.</p>', NULL, 1, 0, CAST(N'1977-01-01T00:00:00.000' AS DateTime), N'Arachnid Productions Ltd.', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1586, N'Pardon My Pups', N'PardonMyPups720p1934', N'Title: Pardon My Pups<br />Summary: Sonny wants a motorcycle for his birthday, and is disappointed when he learns that he is getting a dog instead.<br />Directed by: Charles Lamont<br />Actors: Frank Coghlan Jr., Shirley Temple, Kenneth Howell<br />Production Company: Educational Films Corporation of America<br />Release Date: 26 January 1934 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Mary Lou is excited because today is her older brother Sonny''s birthday. Sonny wants a motorcycle, but his father has decided to buy him a dog instead, mainly because he himself wants to have a dog that he can take hunting. After a dispute with his father, Sonny leaves home. As he walks along a railroad track, he finds a frightened lost dog, and soon he begins to feel differently about dogs.</p>', NULL, 1, 0, CAST(N'1934-01-01T00:00:00.000' AS DateTime), N'Educational Films Corporation of America', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1587, N'Bloodlust!', N'Bloodlust1961', N'Title: Bloodlust!<br />Summary: A crazed hunter kidnaps people and turns them loose on his private estate, where he hunts them for sport.<br />Directed by: Ralph Brooke<br />Actors: Wilton Graff, June Kenney, Walter Brooke<br />Production Company: cinegrafik<br />Release Date: 13 September 1961 (USA)<br />Aspect Ratio: 1.33 : 1<p></p><p>   A group of teen-agers vacationing in the tropics take a boat out to a seemingly deserted island. They soon find, however, that the island is inhabited by a wealthy recluse and his staff. While their host is initially hospitable, he quickly reveals his true purpose: to hunt down and kill each of his visitors, as he has done with everyone unlucky enough to set foot on his island.</p>', NULL, 1, 0, CAST(N'1961-01-01T00:00:00.000' AS DateTime), N'cinegrafik', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1588, N'The Trap', N'tt99345435113', N'Title: The Trap<br />Summary: When a troupe of showgirls with their impresario and press agent vacation at a Malibu Beach resort, two of them are garroted. Charlie takes on the case assisted by Number Two Son Jimmy and faithful chauffeur Birmingham Brown.<br />Directed by: Howard Bretherton<br />Actors: Sidney Toler, Mantan Moreland, Victor Sen Yung<br />Production Company: Monogram Pictures<br />Release Date: 30 November 1946 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   When a troupe of showgirls with their impresario and press agent vacation at a Malibu Beach resort, two of them are garroted. Charlie takes on the case assisted by Number Two Son Jimmy and faithful chauffeur Birmingham Brown.</p>', NULL, 1, 0, CAST(N'1946-01-01T00:00:00.000' AS DateTime), N'Monogram Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1589, N'Dressed to Kill', N'DressedToKill720p1946', N'Title: Dressed to Kill<br />Summary: Sherlock Holmes sets out to discover why a trio of murderous villains, including a dangerously attractive female, are desperate to obtain three unassuming and inexpensive little music boxes.<br />Directed by: Roy William Neill<br />Actors: Basil Rathbone, Nigel Bruce, Patricia Morison<br />Production Company: Universal Pictures<br />Release Date: 7 June 1946 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   Sherlock Holmes is intrigued when Dr. Watson''s friend, Julian ''Stinky'' Emery, visits and tells them of a strange robbery at his flat the previous night. Stinky is an avid collector of music boxes and has several quite expensive pieces in his vast collection. The previous night, someone broke into his flat and knocked him unconscious when he tried to intervene. All they took however was a simple wooden music box he had bought at auction that day for a mere £2. The box was one of three available for sale and as Holmes and Watson begin to trace the other purchasers, it becomes apparent that someone will stop at nothing, including murder, to retrieve all three. When Holmes learns the identity of the music box maker, he is convinced it contains directions to the retrieval of something very valuable that the government has kept from the public.</p>', NULL, 1, 0, CAST(N'1946-01-01T00:00:00.000' AS DateTime), N'Universal Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1590, N'Bulldog Drummond Comes Back', N'BulldogDrummond720p1937', N'Title: Bulldog Drummond Comes Back<br />Summary: The girlfriend of Captain Drummond has been kidnapped by an enemy of Drummond who seeks revenge. But Drummond and his friend Colonel Nielsen at once follow his trail...<br />Directed by: Louis King<br />Actors: John Barrymore, John Howard, Louise Campbell<br />Production Company: Paramount Pictures<br />Release Date: 24 September 1937 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   The girlfriend of Captain Drummond has been kidnapped by an enemy of Drummond who seeks revenge. But Drummond and his friend Colonel Nielsen at once follow his trail...</p>', NULL, 1, 0, CAST(N'1937-01-01T00:00:00.000' AS DateTime), N'Paramount Pictures', NULL)
GO
INSERT [dbo].[Movie] ([ID], [Title], [ApiID], [Description], [OriginalFilePath], [ProcessedIntoStreamableFormat], [DownloadedMovieFiles], [Published], [Creator], [Subject]) VALUES (1591, N'Little Lord Fauntleroy', N'LittleLordFauntleroy720p1936', N'Title: Little Lord Fauntleroy<br />Summary: An American boy turns out to be the long-lost heir of a British fortune. He is sent to live with the cold and unsentimental lord who oversees the trust.<br />Directed by: John Cromwell<br />Actors: Freddie Bartholomew, Dolores Costello, C. Aubrey Smith<br />Production Company: Selznick International Pictures<br />Release Date: 6 March 1936 (USA)<br />Aspect Ratio: 1.37 : 1<p></p><p>   After the death of Cedric (''Ceddie'')''s English father, he and his mother live together in Brooklyn. Cedric''s grandfather, the Earl of Dorincourt, had disowned Cedric''s father when he married an American. But when the Earl''s remaining son dies, he accepts Cedric as Lord Fauntleroy, his heir, and the Earl sends for Cedric and his mother. Cedric uses the first of his newly found wealth to do some favors for his old friends, and then heads to England, where he must try to overcome the Earl''s dislike for Cedric''s mother.</p>', NULL, 0, 0, CAST(N'1936-01-01T00:00:00.000' AS DateTime), N'Selznick International Pictures', NULL)
GO
SET IDENTITY_INSERT [dbo].[Movie] OFF
GO
SET IDENTITY_INSERT [dbo].[MovieGenre] ON 
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2039, 1533, 54)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2040, 1533, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2041, 1533, 56)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2042, 1534, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2043, 1534, 58)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2044, 1534, 59)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2045, 1535, 60)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2046, 1535, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2047, 1535, 62)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2048, 1536, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2049, 1536, 54)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2050, 1536, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2051, 1536, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2052, 1536, 64)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2053, 1537, 60)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2054, 1537, 62)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2055, 1538, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2056, 1538, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2057, 1538, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2058, 1538, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2059, 1539, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2060, 1539, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2061, 1540, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2062, 1540, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2063, 1541, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2064, 1541, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2065, 1541, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2066, 1541, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2067, 1542, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2068, 1542, 59)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2069, 1543, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2070, 1543, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2071, 1543, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2072, 1543, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2073, 1544, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2074, 1544, 69)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2075, 1545, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2076, 1545, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2077, 1545, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2078, 1545, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2079, 1546, 60)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2080, 1546, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2081, 1546, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2082, 1547, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2083, 1547, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2084, 1547, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2085, 1548, 70)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2086, 1549, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2087, 1549, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2088, 1550, 60)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2089, 1550, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2090, 1550, 71)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2091, 1551, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2092, 1551, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2093, 1551, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2094, 1551, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2095, 1551, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2096, 1552, 54)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2097, 1552, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2098, 1553, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2099, 1553, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2100, 1554, 62)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2101, 1555, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2102, 1555, 72)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2103, 1556, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2104, 1556, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2105, 1556, 64)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2106, 1557, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2107, 1558, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2108, 1558, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2109, 1559, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2110, 1559, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2111, 1559, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2112, 1559, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2113, 1560, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2114, 1560, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2115, 1560, 69)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2116, 1561, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2117, 1561, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2118, 1562, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2119, 1563, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2120, 1563, 70)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2121, 1564, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2122, 1564, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2123, 1564, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2124, 1564, 69)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2125, 1565, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2126, 1565, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2127, 1565, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2128, 1566, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2129, 1566, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2130, 1567, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2131, 1568, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2132, 1568, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2133, 1569, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2134, 1569, 62)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2135, 1570, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2136, 1570, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2137, 1570, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2138, 1571, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2139, 1571, 56)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2140, 1571, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2141, 1572, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2142, 1572, 73)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2143, 1572, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2144, 1573, 60)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2145, 1573, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2146, 1573, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2147, 1573, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2148, 1573, 69)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2149, 1573, 62)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2150, 1574, 71)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2151, 1575, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2152, 1575, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2153, 1576, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2154, 1576, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2155, 1576, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2156, 1576, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2157, 1577, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2158, 1578, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2159, 1578, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2160, 1578, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2161, 1579, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2162, 1579, 72)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2163, 1579, 69)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2164, 1580, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2165, 1580, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2166, 1581, 62)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2167, 1582, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2168, 1582, 61)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2169, 1582, 71)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2170, 1583, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2171, 1583, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2172, 1583, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2173, 1584, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2174, 1584, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2175, 1584, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2176, 1585, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2177, 1585, 71)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2178, 1586, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2179, 1586, 59)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2180, 1587, 65)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2181, 1587, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2182, 1588, 57)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2183, 1588, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2184, 1588, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2185, 1588, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2186, 1589, 67)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2187, 1589, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2188, 1590, 63)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2189, 1590, 68)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2190, 1590, 66)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2191, 1591, 55)
GO
INSERT [dbo].[MovieGenre] ([ID], [MovieID], [GenreID]) VALUES (2192, 1591, 58)
GO
SET IDENTITY_INSERT [dbo].[MovieGenre] OFF
GO
SET IDENTITY_INSERT [dbo].[Profile] ON 
GO
INSERT [dbo].[Profile] ([ID], [Name], [Color]) VALUES (0, N'Eray', N'#BAFFC9   ')
GO
INSERT [dbo].[Profile] ([ID], [Name], [Color]) VALUES (1, N'Ryan', N'#FADADD   ')
GO
INSERT [dbo].[Profile] ([ID], [Name], [Color]) VALUES (2, N'Damian', N'#DCC6E0   ')
GO
INSERT [dbo].[Profile] ([ID], [Name], [Color]) VALUES (3, N'Daan', N'#FFB19A   ')
GO
INSERT [dbo].[Profile] ([ID], [Name], [Color]) VALUES (4, N'Dawud', N'#C0E8F9   ')
GO
SET IDENTITY_INSERT [dbo].[Profile] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([ID], [UserID], [Email], [PasswordHash]) VALUES (1, NULL, N'ryanevertzz@gmail.com', N'$2a$12$AUOpbMta0vqvMP858mM7uegyYHgVHVe9o1kI2i5z7nf4JZtc53gV6')
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserProfile] ON 
GO
INSERT [dbo].[UserProfile] ([ID], [UserID], [ProfileID]) VALUES (0, 1, 1)
GO
INSERT [dbo].[UserProfile] ([ID], [UserID], [ProfileID]) VALUES (1, 1, 2)
GO
INSERT [dbo].[UserProfile] ([ID], [UserID], [ProfileID]) VALUES (2, 1, 3)
GO
INSERT [dbo].[UserProfile] ([ID], [UserID], [ProfileID]) VALUES (3, 1, 4)
GO
INSERT [dbo].[UserProfile] ([ID], [UserID], [ProfileID]) VALUES (5, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[UserProfile] OFF
GO
ALTER TABLE [dbo].[Movie] ADD  DEFAULT ((0)) FOR [ProcessedIntoStreamableFormat]
GO
ALTER TABLE [dbo].[Movie] ADD  DEFAULT ((0)) FOR [DownloadedMovieFiles]
GO
ALTER TABLE [dbo].[MovieGenre]  WITH CHECK ADD FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genre] ([ID])
GO
ALTER TABLE [dbo].[MovieGenre]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movie] ([ID])
GO
ALTER TABLE [dbo].[MovieHistory]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movie] ([ID])
GO
ALTER TABLE [dbo].[MovieHistory]  WITH CHECK ADD  CONSTRAINT [FK__MovieHist__Profi__47DBAE45] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ID])
GO
ALTER TABLE [dbo].[MovieHistory] CHECK CONSTRAINT [FK__MovieHist__Profi__47DBAE45]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK__UserProfi__Profi__46E78A0C] FOREIGN KEY([ProfileID])
REFERENCES [dbo].[Profile] ([ID])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK__UserProfi__Profi__46E78A0C]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK__UserProfi__UserI__45F365D3] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK__UserProfi__UserI__45F365D3]
GO
USE [master]
GO
ALTER DATABASE [NextStream] SET  READ_WRITE 
GO
