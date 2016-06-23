declare namespace file = "http://expath.org/ns/file";
declare namespace dxf = "http://dhis2.org/schema/dxf/2.0";
declare variable $file as item() external;


(:
Usage Example:
 basex  -w -b "file=metadata.xml"   cleanup_metadata.xq  
:)

copy $dxf := fetch:xml($file, map { 'xinclude': false() })/dxf:metaData
modify (
  for $e in ( $dxf//dxf:users, $dxf//dxf:user ,  $dxf//dxf:userObject)
    return delete node $e
)

return file:write($file,$dxf)
