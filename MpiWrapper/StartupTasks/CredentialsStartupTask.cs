using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.ServiceModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HSR.AzureEE.MpiWrapper.StartupTasks
{
    
    public class CredentialsStartupTask : IMpiStartupTask
    {
        public string _location, _username, _password; //wcf..

        public void Setup(string location, string username, string password)
        {
            _location = location;
            _username = username;
            _password = password;
        }

        public void Run()
        {
            //Build arguments
            var arguments = String.Format(" /add:{0} /user:{1} /pass:{2} ", _location, _username, _password);
            

            var procCmdKey = new Process();
            procCmdKey.StartInfo = new ProcessStartInfo()
            {
                FileName = Path.Combine(Environment.SystemDirectory, "cmdkey.exe"),
                Arguments = arguments,
                UseShellExecute = false
            };

            procCmdKey.Start();
            procCmdKey.WaitForExit(10000);
        }
    }
}
