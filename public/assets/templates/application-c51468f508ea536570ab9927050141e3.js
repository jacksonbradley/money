Ember.TEMPLATES.application=Ember.Handlebars.template(function(a,s,n,e,t){function l(a,s){var e,t,l="";return s.buffer.push("\n            <li><a "),e={},t={},s.buffer.push(c(n.action.call(a,"toList","year",{hash:{},contexts:[a,a],types:["STRING","ID"],hashContexts:t,hashTypes:e,data:s}))),s.buffer.push(">"),e={},t={},s.buffer.push(c(n._triageMustache.call(a,"year",{hash:{},contexts:[a],types:["ID"],hashContexts:t,hashTypes:e,data:s}))),s.buffer.push("</a></li>\n          "),l}this.compilerInfo=[4,">= 1.0.0"],n=this.merge(n,Ember.Handlebars.helpers),t=t||{};var o,h,r,p="",c=this.escapeExpression,u=this;return t.buffer.push('<nav class="navbar navbar-default" role="navigation">\n  <!-- Brand and toggle get grouped for better mobile display -->\n  <div class="navbar-header">\n    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">\n      <span class="sr-only">Toggle navigation</span>\n      <span class="icon-bar"></span>\n      <span class="icon-bar"></span>\n      <span class="icon-bar"></span>\n    </button>\n    <a class="navbar-brand" '),h={},r={},t.buffer.push(c(n.action.call(s,"toRoot",{hash:{},contexts:[s],types:["ID"],hashContexts:r,hashTypes:h,data:t}))),t.buffer.push('>Money</a>\n  </div>\n\n  <!-- Collect the nav links, forms, and other content for toggling -->\n  <div class="collapse navbar-collapse navbar-ex1-collapse">\n    <ul class="nav navbar-nav">\n      <li class="dropdown">\n        <a class="dropdown-toggle" data-toggle="dropdown">View <b class="caret"></b></a>\n        <ul class="dropdown-menu">\n          <li><a '),h={},r={},t.buffer.push(c(n.action.call(s,"toList",{hash:{},contexts:[s],types:["STRING"],hashContexts:r,hashTypes:h,data:t}))),t.buffer.push(">List</a></li>\n          <li><a "),h={},r={},t.buffer.push(c(n.action.call(s,"toSummary",{hash:{},contexts:[s],types:["STRING"],hashContexts:r,hashTypes:h,data:t}))),t.buffer.push(">Summary</a></li>\n          <li><a "),h={},r={},t.buffer.push(c(n.action.call(s,"toTrend",{hash:{},contexts:[s],types:["STRING"],hashContexts:r,hashTypes:h,data:t}))),t.buffer.push('>Trend</a></li>\n        </ul>\n      </li>\n      <li class="dropdown">\n        <a class="dropdown-toggle" data-toggle="dropdown">Select <b class="caret"></b></a>\n        <ul class="dropdown-menu">\n          '),h={},r={},o=n.each.call(s,"year","in","listYear",{hash:{},inverse:u.noop,fn:u.program(1,l,t),contexts:[s,s,s],types:["ID","ID","ID"],hashContexts:r,hashTypes:h,data:t}),(o||0===o)&&t.buffer.push(o),t.buffer.push('\n        </ul>\n      </li>\n    </ul>\n    <ul class="nav navbar-nav navbar-right">\n      <li class="dropdown">\n        <a class="dropdown-toggle" data-toggle="dropdown">Profile <b class="caret"></b></a>\n        <ul class="dropdown-menu">\n          <li><a '),h={},r={},t.buffer.push(c(n.action.call(s,"logout",{hash:{},contexts:[s],types:["STRING"],hashContexts:r,hashTypes:h,data:t}))),t.buffer.push(">Logout</a></li>\n          <li><a "),h={},r={},t.buffer.push(c(n.action.call(s,"toUpload",{hash:{},contexts:[s],types:["STRING"],hashContexts:r,hashTypes:h,data:t}))),t.buffer.push(" >Upload</a></li>\n\n        </ul>\n      </li>\n    </ul>\n  </div><!-- /.navbar-collapse -->\n</nav>\n"),h={},r={},t.buffer.push(c(n._triageMustache.call(s,"outlet",{hash:{},contexts:[s],types:["ID"],hashContexts:r,hashTypes:h,data:t}))),t.buffer.push("\n"),p});