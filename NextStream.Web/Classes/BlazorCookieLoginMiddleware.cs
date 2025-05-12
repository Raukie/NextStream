using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using NextStream.Services;
using System.Collections.Concurrent;
using static NextStream.Web.Components.Pages.Login;
using System.Security.Claims;

public class LoginInfo
{
    public string Email { get; set; }

    public string Password { get; set; }
}

public class BlazorCookieLoginMiddleware
{
    public static IDictionary<Guid, LoginInfo> Logins { get; private set; }
        = new ConcurrentDictionary<Guid, LoginInfo>();


    private readonly RequestDelegate _next;

    public BlazorCookieLoginMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task Invoke(HttpContext context, UserService userService, UserDataService userData)
    {
        if(context.User.Identity?.Name != null)
        {
            userData.UserName = context.User.Identity.Name;
        }
        if (context.Request.Path == "/login" && context.Request.Query.ContainsKey("key"))
        {
            var key = Guid.Parse(context.Request.Query["key"]!);
            if (!Logins.ContainsKey(key))
            {
                context.Response.Redirect("/");
            }
            var info = Logins[key];

            var user = userService.GetUser(info.Email);

            Logins.Remove(key);

            var claims = new List<Claim> {
                    new Claim(ClaimTypes.Name, info.Email!)
                };

            userData.UserName = info.Email;
            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            await context.SignInAsync(principal);
            context.Response.Redirect("/");
            return;
        }
        else
        {
            await _next.Invoke(context);
        }
    }
}