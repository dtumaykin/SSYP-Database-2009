<%@ Page Language="C#" %>
<%@ Import Namespace="System.Xml.Xsl" %> 
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Xml.XPath" %>
<%@ Import Namespace="System.IO" %>
<script language="C#" runat="server" debug="true">
    private int nowmillisecs()
    {
        return System.DateTime.Now.Millisecond + System.DateTime.Now.Second * 1000;
    }

    private void Page_Load(object sender, System.EventArgs e)
    {
     //   int StartTime = nowmillisecs();
        NameValueCollection pcoll = new NameValueCollection();
        XsltArgumentList alist = new XsltArgumentList();
        pcoll.Add(this.Request.QueryString);
        pcoll.Add(this.Request.Form);

        if (pcoll["id"] != null) alist.AddParam("id", "", pcoll["id"]);
        if (pcoll["type"] != null) alist.AddParam("type", "", pcoll["type"]);
        if (pcoll["search"] != null) alist.AddParam("search", "", pcoll["search"]);

        if (pcoll["style"]!=null)
        {
            Response.Cookies["style_cook"].Value = pcoll["style"];
            alist.AddParam("style", "", Response.Cookies["style_cook"].Value);
        } else
        {
            if (Request.Cookies["style_cook"] != null)
            {
                alist.AddParam("style", "", Request.Cookies["style_cook"].Value);
            }
            else
            {
                Response.Cookies["style_cook"].Value = "blue";
                alist.AddParam("style", "", "blue");
            }
        }

        if (pcoll["size"] != null)
        {
            Response.Cookies["size_cook"].Value = pcoll["size"];
            alist.AddParam("size", "", Response.Cookies["size_cook"].Value);
        }
        else
        {
            if (Request.Cookies["size_cook"] != null)
            {
                alist.AddParam("size", "", Request.Cookies["size_cook"].Value);
            }
            else
            {
                Response.Cookies["size_cook"].Value = "normal";
                alist.AddParam("size", "", "normal");
            }
        }
        
        
        
        Response.ContentType = "text/html";


        string xsl_uri = Server.MapPath("index.xsl");

        XmlDocument xdoc = null;
        XmlElement data = null;
        XslCompiledTransform transformer = null;
        XPathDocument xpdoc = null;

        transformer = Application["transformer"] as XslCompiledTransform;
        xpdoc = Application["xpdoc"] as XPathDocument;
        if ((xpdoc == null) || (transformer == null))
        {
           // LogLine("Loading data", Server.MapPath("log.txt"));
            transformer = new XslCompiledTransform();
            xdoc = new XmlDocument();
            data = xdoc.CreateElement("data");
            LoadBase(xdoc, data);
            xpdoc = new XPathDocument(new XmlNodeReader(data));
            transformer.Load(xsl_uri);
            Application["transformer"] = transformer;
            Application["xpdoc"] = xpdoc;
        }

        transformer.Transform(xpdoc, alist, Response.Output);

       // int FinishTime = nowmillisecs();

      //  LogLine("" + (FinishTime - StartTime) + " ms.", Server.MapPath("log.txt"));
    }
 /*   private static void LogLine(string s, string path)
    {
        System.IO.StreamWriter sw = System.IO.File.AppendText(path);
        sw.WriteLine(s);
        sw.Close();
    }
  */
    private void LoadBase(XmlDocument xdoc, XmlElement data)
    {
        string path = Server.MapPath("XML/");

        loadAllXml(path,xdoc,data);

    }
    private void loadAllXml(string path, XmlDocument xdoc, XmlElement data)
    {
        DirectoryInfo ourDir = new DirectoryInfo(path);
        foreach (FileInfo finfo in ourDir.GetFiles("*.xml"))
        {
            
            xdoc.Load(path+finfo.Name);
            data.AppendChild(xdoc.DocumentElement);
        }
        foreach (DirectoryInfo difo in ourDir.GetDirectories())
        {
            loadAllXml(path + difo.Name+"\\",xdoc,data);
        }
    }
</script>