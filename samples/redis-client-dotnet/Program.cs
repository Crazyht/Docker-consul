using Newtonsoft.Json;
using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;

namespace MyRedisClient
{
  class Program
  {

    private static Random rnd = new Random();

    private const string CacheKey = "MyCache";
    private const string UsrCacheKey = "Usr_";

    static void Main(string[] args)
    {
        while(true) {
        try{
            ConfigurationOptions redisConf = new ConfigurationOptions
            {
                ServiceName = "mymaster",
                TieBreaker = "",
                DefaultVersion = new Version(3, 0),
                ReconnectRetryPolicy = new ExponentialRetry(1000, 10_000),
                ClientName = "My .Net Client",
                ResolveDns = false,
                AllowAdmin = true,
                SyncTimeout = 5000,
                AbortOnConnectFail = false,
                CommandMap = CommandMap.Sentinel
            };
            redisConf.EndPoints.Add("Sentinel-Asia.service.dc1.consul", 26379);
            Console.WriteLine($"{redisConf.ToString()}");
            ConnectionMultiplexer cnxSentienl = ConnectionMultiplexer.Connect(redisConf);
            IServer server = cnxSentienl.GetServer(redisConf.EndPoints[0]);
            Console.WriteLine($"Current master : {server.SentinelGetMasterAddressByName(redisConf.ServiceName)}");
        }
        catch{}
        Thread.Sleep(10_000);
        }
    }
  }
}
