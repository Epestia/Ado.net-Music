using Microsoft.Data.SqlClient;

string connectionString = "Data Source=GOS-VDI206\\TFTIC;Initial Catalog=DB_Music;Integrated Security=True;Connect Timeout=60;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False";

SqlConnection connection = new SqlConnection(connectionString);

connection.Open();
Console.WriteLine(connection.State);
connection.Close();
Console.WriteLine(connection.State);

// select la date
using (SqlConnection connection = new SqlConnection(connectionString))
{
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "SELECT GETDATE() as date";

        connection.Open();
        string date = command.ExecuteScalar().ToString();
        Console.WriteLine(date);
    }
}
 
//Insert artist
using (SqlConnection connection = new SqlConnection(connectionString))
{
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "INSERT INTO dbo.[Artist] ( [Name],[CreationDate],[RetirementDate],[Country]) OUTPUT INSERTED.Id VALUES ('Metallica','2024-12-20','2034-12-20','France') ";

        connection.Open();
        int IdArtist = (int)command.ExecuteScalar();
        Console.WriteLine(IdArtist);
    }
}

//Delete artist
using (SqlConnection connection = new SqlConnection(connectionString))
{
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "DELETE FROM dbo.[Artist] WHERE id = 1 ";
        connection.Open();
        int rows = command.ExecuteNonQuery();

        if (rows > 0)
        {
            Console.WriteLine("bye bye");
        }
        else
        {
            Console.WriteLine("je suis toujours la");
        }
    }
}

//select aya
using (SqlConnection connection = new SqlConnection(connectionString))
{
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "SELECT * FROM dbo.[Artist] WHERE name like 'aya%'";

        connection.Open();

        using (SqlDataReader reader = command.ExecuteReader())
        {
            while (reader.Read())
            {
                int id = (int)reader["Id"];
                string name = reader["Name"].ToString();
                DateTime creationDate = (DateTime)reader["Creation_Date"];
                DateTime retirementDate = (DateTime)reader["Retirement_Date"];
                string country = reader["Country"].ToString();

                Console.WriteLine($"{id} - {name} qui débute sa carrière le {creationDate.ToString("dd-MM-yyyy")} vient de {country} ");
            }

        }
    }
}

//insert music
using (SqlConnection connection = new SqlConnection(connectionString))
{
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "INSERT INTO [dbo].[Music] ( [Title], [RealiseDate],  [Duration],  [SpotifyLink]) OUTPUT INSERTED.Title VALUES ( 'Master of puppets',  '2018-08-06',  '00:04:35',    'https://open.spotify.com/track/xyz123');";
        connection.Open();
        string TitleMusic = command.ExecuteScalar().ToString();
        Console.WriteLine(TitleMusic);
    }
}

//insert Artistmusic
using (SqlConnection connection = new SqlConnection(connectionString))
{
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "INSERT INTO [dbo].[ArtistMusic] ( [MusicId], [ArtistID]) OUTPUT INSERTED.Id VALUES (4,6 );";
        connection.Open();
        int ArtiM = (int)command.ExecuteScalar();
        Console.WriteLine(ArtiM);
    }
}

//Jointure
using (SqlConnection connection = new SqlConnection(connectionString))
{
    using (SqlCommand command = connection.CreateCommand())
    {
        command.CommandText = "SELECT A.Name, A.CreationDate, A.Country, M.Title, M.Duration, M.RealiseDate" +
        "FROM ArtistMusic AM " +
        "JOIN Music M ON AM.MusicId = M.Id " +
        "JOIN Artist A ON AM.ArtistID = A.Id " +
        "WHERE A.Id = 6 ";

        connection.Open();

        using (SqlDataReader reader = command.ExecuteReader())
        {
            while (reader.Read())
            {
                Console.WriteLine($"{reader["Name"].ToString()} - {reader["Title"].ToString()}");
            }
        }

    }
}