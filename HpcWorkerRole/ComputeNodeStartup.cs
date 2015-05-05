using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HSR.AzureEE.HpcWorkerRole
{
    public class ComputeNodeStartup : AbstractStartup
    {

        protected void MakeNextJobReady()
        {
            var nextJob = this.azureStorage.GetNextJob();

            if (nextJob == null)
            {
                return; //do nothing
            }
            if (availableJobs.Contains(nextJob.RowKey))
            {
                return;
            }

            azureStorage.WriteLog("Dequeed Job " + nextJob.RowKey);
            //ansys: only headnode downloads job... here for compatibility purposes
            azureStorage.WriteLog("Job ready " + nextJob.RowKey);
            SetInstanceActive();
        }

        public override void Start()
        {
            SetInstanceActive();
        }

        public override void RunJob()
        {
            MakeNextJobReady();
        }
    }
}
