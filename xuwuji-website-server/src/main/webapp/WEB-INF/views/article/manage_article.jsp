<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/dashboard.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/RequestUrl.js"></script>
<title>Article</title>
</head>
<body>

  <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#">Dashboard</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="#">Profile</a></li>
            <li><a href="#">Help</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li>
            <li><a href="#">Reports</a></li>
            <li><a href="#">Analytics</a></li>
            <li><a href="#">Export</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item</a></li>
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
            <li><a href="">More navigation</a></li>
          </ul>
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">Dashboard</h1>

          <div class="row placeholders">
            <div class="col-xs-6 col-sm-3 placeholder">
              <h4>Articles</h4><h4  id='total_articles'></h4>
             
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <h4>Category</h4>
              <h4 id='total_categories'></h4>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <h4>Label</h4>
              <span class="text-muted">Something else</span>
            </div>
          </div>

          <h2 class="sub-header">Articles</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                   <th>Id</th>
                  <th>Title</th>
                  <th>Category</th>
                  <th>Time</th>
                  <th>Tags</th>
                  <th></th>
                </tr>
              </thead>
              <tbody id='table_content'>
              </tbody>
            </table>
            <a id="previous_page" onclick='previousPage()'>previous</a>
            <span id='current_page'></span>
            <a id="next_page" onclick='nextPage()'>next</a>
            <a id="max_page_href" onclick='lastPage()'></a>
          </div>
        </div>
      </div>
    </div>
</body>

<script type="text/javascript">







var func1 = null; 
var func2 = null;  

$.getJSON('http://localhost:8080/xuwuji-website-server/api/article/getInfo/1',function(data){ 
        func1 = function(a){ 
                return function(){ 
                        console.log(a); 
                }; 
        }(data); 
        
        func2 = function(a){ 
                return function(){ 
                        console.log(a); 
                } 
        }(data); 

        func1();
}); 




















 /*  String buffer function starts here...*/
function StringBuffer() {
  this.__strings__ = [];
};
StringBuffer.prototype.append = function(str) {
  this.__strings__.push(str);
};
StringBuffer.prototype.toString = function() {
  return this.__strings__.join('');
};
/*  String buffer function ends here ...*/






/* by default, the page shows the latest 10 articles,show the articles function starts here ...*/
var line = new StringBuffer();
$.getJSON('http://localhost:8080/xuwuji-website-server/api/article/getArticles/1', function(data) {
  $.each(data, function(index, article) {
        line.append('<tr><td>'+article.id+'</td><td>'+article.title+'</td><td>'+article.category+'</td><td>'+article.time+'</td><td>'+article.tags+'</td><td><button type=\'button\' class=\'btn btn-info btn-lg\' style=\'padding-top: 0px; padding-bottom: 0px\' >delete</button><button type=\'button\' class=\'btn btn-info btn-lg\' style=\'padding-top: 0px; padding-bottom: 0px\' >update</button></td><tr>');
      });
 //console.log(line.toString());
  var $table_content=$('#table_content');
  $table_content.html(line.toString());
  setInfo(1);
});
/* show the articles function ends here ...*/




/*  set the general info for a particular function starts here ...*/
function setInfo(pageNum){
  var url='http://localhost:8080/xuwuji-website-server/api/article/getInfo/'+pageNum;
  $.getJSON(url, function(data){
var total_articles=data.total_articles;
var total_categories=data.total_categories;
var max_page=data.max_page;
var current_page_number=data.current_page_number;
var $total_articles=$('#total_articles');
$total_articles.text(total_articles);
var $total_categories=$('#total_categories');
$total_categories.text(total_categories);
var $max_page_href=$('#max_page_href');
$max_page_href.text(max_page);
var $current_page=$('#current_page');
$current_page.text(current_page_number+' / '+max_page);
});
}
/*  set the general info function ends here ...*/



/* show a perticular article page function starts here ...*/
function getPage(pagenumber){
var line = new StringBuffer();
var url='http://localhost:8080/xuwuji-website-server/api/article/getArticles/'+pagenumber;
//console.log(url);
$.getJSON(url, function(data) {
  $.each(data, function(index, article) {
        line.append('<tr><td>'+article.id+'</td><td>'+article.title+'</td><td>'+article.category+'</td><td>'+article.time+'</td><td>'+article.tags+'</td><td><button type=\'button\' class=\'btn btn-info btn-lg\' style=\'padding-top: 0px; padding-bottom: 0px\' >delete</button><button type=\'button\' class=\'btn btn-info btn-lg\' style=\'padding-top: 0px; padding-bottom: 0px\' >update</button></td><tr>');
      });
  //console.log(line.toString());
  var $table_content=$('#table_content');
  $table_content.html(line.toString());
});
}
/* show a perticular article page function ends here ...*/



function getCurrentPage(){
  $.getJSON('http://localhost:8080/xuwuji-website-server/api/article/getInfo', function(data){
var total_articles=data.total_articles;
var total_categories=data.total_categories;
var max_page=data.max_page;
var current_page_number=data.current_page_number;
});
}

/* show a previous article page function starts here ...*/
function previousPage(){
var $max_page=$('#max_page');
var $current_page=$('#current_page');
var max_page=$max_page.text();
var current_page_number=$current_page.text();
current_page_number=current_page_number.slice(0,current_page_number.indexOf('/'));
    if(parseInt(current_page_number)==1){ 
    }else{
      getPage(parseInt(current_page_number)-1);
      setInfo(parseInt(current_page_number)-1);
    }
  }

/* show a previous article page function ends here ...*/

/* show a next article page function starts here ...*/
function nextPage(){
var $max_page=$('#max_page_href');
var $current_page=$('#current_page');
var max_page=$max_page.text();
var current_page_number=$current_page.text();
current_page_number=current_page_number.slice(0,current_page_number.indexOf('/'));
//console.log(max_page);
    if(parseInt(current_page_number)==parseInt(max_page)){ 
    }else{
      getPage(parseInt(current_page_number)+1);
      setInfo(parseInt(current_page_number)+1);
    }
  }

/* show a next article page function ends here ...*/

/* show the last article page function starts here ...*/
function lastPage(){
var $current_page=$('#current_page');
var current_page_number=$current_page.text();
current_page_number=current_page_number.slice(0,current_page_number.indexOf('/'));
var $max_page_href=$('#max_page_href');
var max_page=$max_page_href.text();
max_page=parseInt(max_page);
//console.log(max_page);
    if(parseInt(current_page_number)==max_page){ 
    }else{
      getPage(max_page);
      setInfo(max_page);
    }
}
/* show the last article page function starts here ...*/
</script>

</html>