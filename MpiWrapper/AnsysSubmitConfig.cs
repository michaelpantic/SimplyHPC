using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace HSR.AzureEE.MpiWrapper
{
    public class AnsysSubmitConfig
    {
        private string _batchFilePath;

        private Dictionary<string, string> _newConfigItems;

        public AnsysSubmitConfig(string path)
        {
            _newConfigItems = new Dictionary<string, string>();
            _batchFilePath = path;
        }

        public void SetConfigItems(string key, string value)
        {
            _newConfigItems.Add(key, value);
        }

        public string ApplyAndSave()
        {
            //read full file
            string fileContent = File.ReadAllText(_batchFilePath);
            foreach (string key in _newConfigItems.Keys)
            {
                string value = _newConfigItems[key];

                fileContent = Regex.Replace(fileContent, "^(set " + key + "=)(.+)$", "${1}" + value.Replace("$", "$$") + System.Environment.NewLine, RegexOptions.IgnoreCase | RegexOptions.Multiline);
            }
            var fileName = Path.GetFileNameWithoutExtension(_batchFilePath);
            var extension = Path.GetExtension(_batchFilePath);
            var folder = Path.GetDirectoryName(_batchFilePath);
            var newFile = Path.Combine(folder, fileName + Path.GetRandomFileName());
            newFile = Path.ChangeExtension(newFile, extension);
            File.WriteAllText(newFile, fileContent);

            return newFile;

        }
    }
}
