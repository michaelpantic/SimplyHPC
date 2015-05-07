using HSR.AzureEE.MpiWrapper.StartupTasks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace HSR.AzureEE.MpiWrapper
{

    class Program
    {
        static void Main(string[] args)
        {
            IMPIRunner runner = new WCFMPIRunner();

            //FIXME: Just for test!
            var startupTask = new CredentialsStartupTask();
            startupTask.Setup("hsransys.file.core.windows.net", "hsransys", "pass");
            startupTask.Run();
            Console.WriteLine("CredentialsStartupTask finished");

            using (var host = new ServiceHost(new WCFMPIRunner(), new Uri("net.pipe://localhost")))
            {

                host.AddServiceEndpoint(typeof(IMPIRunner),
                                           new NetNamedPipeBinding(),
                                           "MPIRunner");


                host.Open();
                Console.WriteLine(@"MPIRunner started...");

                while (Console.ReadLine() != "exit")
                {
                    //run
                }

                host.Close();
            }
        }
    }
    

}
