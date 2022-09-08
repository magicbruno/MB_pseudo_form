using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DemoMbPseudofrm.ApiControllers
{
    public class ApiControllerResponse
    {
        public bool Success { get; set; }
        public int Exitcode { get; set; }   
        public string Message { get; set; }
        public object Data { get; set; }
    }
}