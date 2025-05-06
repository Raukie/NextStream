using NextStream.Web;
using NextStream.Web.Components;
using NextStream.DataAccessLayer;
using Microsoft.Extensions.FileProviders;
using NextStream.Services;
using Microsoft.AspNetCore.Authentication.Cookies;

var builder = WebApplication.CreateBuilder(args);


// Add service defaults & Aspire components.
builder.AddServiceDefaults();

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/login";
        options.AccessDeniedPath = "/login";
    });

builder.Services.AddAuthorization();

builder.Services.AddLogging(logging =>
{
    logging.AddFilter("Microsoft.EntityFrameworkCore.Database.Command", LogLevel.Warning);
    logging.ClearProviders();
    logging.AddConsole();
});

builder.Services.AddHttpContextAccessor();
builder.Services.AddOutputCache();
builder.Services.AddSqlServer<NextStreamContext>("Data Source=localhost\\SQLEXPRESS;Initial Catalog=NextStream;Integrated Security=True;Trust Server Certificate=True");
builder.Services.AddScoped(typeof(MovieService));
builder.Services.AddScoped<UserService>();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseFileServer(new FileServerOptions()
{
    FileProvider = new PhysicalFileProvider("C:\\NextStream\\Thumbnails"),
    EnableDirectoryBrowsing = false,
    RequestPath = "/Thumb"
});

app.UseStaticFiles();
app.UseAntiforgery();
app.UseAuthentication();
app.UseAuthorization();
app.UseOutputCache();
app.UseMiddleware<BlazorCookieLoginMiddleware>();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.MapDefaultEndpoints();

app.Run();
