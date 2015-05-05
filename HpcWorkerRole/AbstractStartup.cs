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
            string basePath = @"X:\simplyHpcData"; //Temporary: Fixed basepath to shared storage
            return Path.Combine(basePath, hpcDeploymentLabel, jobid);
        }

        public abstract void Start();
        public abstract void RunJob();

       

        
        public void SetInstanceActive()
        { 
            //get IP of this instance
            var internalIP = RoleEnvironment.CurrentRoleInstance.InstanceEndpoints["mpiEndpointTCP"].IPEndpoint.Address.ToString();

            //set this host as ready
            azureStorage.SetHostStatus(instanceIndex, internalIP, availableJobs);
            azureStorage.WriteLog("Instance state update");
        }
    }
}
