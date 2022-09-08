using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMbPseudofrm.ApiControllers
{
    public class PseudoFormModel
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Value { get; set; }
        public string Label { get; set; }
        public string Detail { get; set; }

    }

    public class PseudoFormModelCollection : List<PseudoFormModel>
    {
        public PseudoFormModel GetByDetail(string detail)
        {
            foreach(var item in this)
                if(item.Detail == detail)
                    return item;
            return null;
        }

        public PseudoFormModel GetByName(string name)
        {
            foreach (var item in this)
                if(name == item.Name)
                    return item;
            return null;
        }
    }
}