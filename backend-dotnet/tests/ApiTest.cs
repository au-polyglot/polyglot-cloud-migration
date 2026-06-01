using Microsoft.AspNetCore.Mvc.Testing;
using System.Net;

public class ApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;

    public ApiTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task StatusEndpoint_ReturnsOk()
    {
        var response = await _client.GetAsync("/api/status");
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }
}