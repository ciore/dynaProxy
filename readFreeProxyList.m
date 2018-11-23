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

function data=readFreeProxyList(n)

pageStr=webread('https://free-proxy-list.net');

is=strfind(pageStr,'<tr>');
ie=strfind(pageStr,'</tr>');
for j=2:n+1
  str=pageStr(is(j):ie(j));
  i=min(strfind(str,'<td>'))+4;
  i(2)=min(strfind(str,'</td>'))-1;
  data.ip(j-1,1)={str(i(1):i(2))};
  str=str(i(2)+6:end);
  i=min(strfind(str,'<td>'))+4;
  i(2)=min(strfind(str,'</td>'))-1;
  data.port(j-1,1)={str(i(1):i(2))};
  str=str(i(2)+6:end);
  i=min(strfind(str,'<td>'))+4;
  i(2)=min(strfind(str,'</td>'))-1;
  data.code(j-1,1)={str(i(1):i(2))};
  str=str(i(2)+6:end);
  i=min(strfind(str,'<td class'))+15;
  i(2)=min(strfind(str,'</td>'))-1;
  data.country(j-1,1)={str(i(1):i(2))};
  str=str(i(2)+6:end);
  i=min(strfind(str,'<td>'))+4;
  i(2)=min(strfind(str,'</td>'))-1;
  data.anon(j-1,1)={str(i(1):i(2))};
  str=str(i(2)+6:end);
  i=min(strfind(str,'<td class'))+15;
  i(2)=min(strfind(str,'</td>'))-1;
  if strcmp(str(i(1):i(2)),'no')
    data.google(j-1,1)=0;
  elseif strcmp(str(i(1):i(2)),'yes')
    data.google(j-1,1)=1;
  end
  str=str(i(2)+6:end);
  i=min(strfind(str,'<td class'))+15;
  i(2)=min(strfind(str,'</td>'))-1;
  if strcmp(str(i(1):i(2)),'no')
    data.https(j-1,1)=0;
  elseif strcmp(str(i(1):i(2)),'yes')
    data.https(j-1,1)=1;
  end
  str=str(i(2)+6:end);
  i=min(strfind(str,'<td class'))+15;
  i(2)=min(strfind(str,'</td>'))-1;
  data.last(j-1,1)={str(i(1):i(2))};
end