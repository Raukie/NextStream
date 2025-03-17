var builder = DistributedApplication.CreateBuilder(args);

var apiService = builder.AddProject<Projects.NextStream_ApiService>("apiservice");

builder.AddProject<Projects.NextStream_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    .WithReference(apiService);

builder.Build().Run();
