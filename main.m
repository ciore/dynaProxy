% This file is part of dynaProxy, a code to dynamiclly set the proxy for
% a websearch using a list of online free proxies.
% 
% Copyright (C) 2018 Ciaran O'Reilly <ciaran@kth.se>
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

clear

%% read in the current list of available proxies
proxy=readFreeProxyList(100);

%% try reading website content using a proxy while handling exceptions
pageStr='';
i=1;
while isempty(pageStr)
  % dynamically set proxy -- see "methods('com.mathworks.mlwidgets.html.HTMLPrefs')"
  com.mathworks.mlwidgets.html.HTMLPrefs.setProxyHost(proxy.ip{i})
  com.mathworks.mlwidgets.html.HTMLPrefs.setProxyPort(proxy.port{i})
  com.mathworks.mlwidgets.html.HTMLPrefs.setUseProxy(true)
  try
    pageStr=webread('https://www.kth.se/profile/ciaran');
    fprintf(['Page successfully read using proxy ',num2str(i),'\n'])
  catch
    i=i+1;
  end
end

%% unset proxy
com.mathworks.mlwidgets.html.HTMLPrefs.setUseProxy(false)