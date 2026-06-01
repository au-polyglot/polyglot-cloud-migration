var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

var app = builder.Build();

app.UseCors("AllowAll");

app.MapGet("/api/status", () => new { status = "ok", message = "Hello from .NET API v1.0", version = "1.0" });

app.MapGet("/api/tasks", () => new[]
{
    new { id = 1, title = "Task One", done = false },
    new { id = 2, title = "Task Two", done = true },
    new { id = 3, title = "Task Three", done = false }
});

app.MapPost("/api/tasks", (dynamic task) => Results.Created("/api/tasks", task));

app.Run();