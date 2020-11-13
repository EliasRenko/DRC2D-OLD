package drc.core;

#if js

typedef Runtime = drc.backend.web.core.Runtime;

#elseif cpp

typedef Runtime = drc.backend.native.core.Runtime;

#end