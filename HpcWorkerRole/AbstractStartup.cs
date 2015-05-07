using HSR.AzureEE.Controller.Storage;
using Ionic.Zip;
using Microsoft.WindowsAzure.ServiceRuntime;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HSR.AzureEE.HpcWorkerRole
{
    public abstract class AbstractStartup
    {
        protected List<string> availableJobs = new List<string>();
        protected int instanceIndex { get; set; }
        protected string hpcDeploymentLabel { get; set; }
        protected AzureStorageHelper azureStorage { get; set; }

        public void Configure(string hpcDeploymentLabel, int instanceId, string storageConnection)
        {
            this.hpcDeploymentLabel = hpcDeploymentLabel;
            this.instanceIndex = instanceId;
            this.azureStorage = new AzureStorageHelper(hpcDeploymentLabel, storageConnection);
            
        }

        protected string GetJobDirectory(string jobid)
        {
            string basePath = RoleEnvironment.GetLocalResource("jobdata").RootPath;
            return Path.Combine(basePath, jobid);
        }

        protected string GetJobDirectoryAsShare(string jobid)
        {
            string basePath = RoleEnvironment.GetLocalResource("jobdata").RootPath;
            string machineUNC = @"\\" + InternalIP + @"\";
            string basePathUNC = basePath.Replace(":", "");
            return Path.Combine(machineUNC, basePathUNC, jobid);
        }

        public abstract void Start();
        public abstract void RunJob();


        public string InternalIP
        {

            get
            {
                return RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["mpiEndpointTCP"].IPEndpoint.Address.ToString();
            }
        }
        
        public void SetInstanceActive()
        { 
            //get IP of this instance
          

            //set this host as ready
            azureStorage.SetHostStatus(instanceIndex, InternalIP, availableJobs);
            azureStorage.WriteLog("Instance state update");
        }
    }
}
