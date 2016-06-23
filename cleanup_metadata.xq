declare namespace file = "http://expath.org/ns/file";
declare namespace dxf = "http://dhis2.org/schema/dxf/2.0";
declare variable $file as item() external;


(:
Usage Example:
 basex  -w -b "file=metadata.xml"   cleanup_metadata.xq  
:)

copy $dxf := fetch:xml($file, map { 'xinclude': false() })/dxf:metaData
modify (
  let $dels := ( 
      $dxf//dxf:users, $dxf//dxf:user ,  $dxf//dxf:userObject , 
      $dxf//dxf:organisationUnits, $dxf//dxf:organisationUnit, 
      $dxf//dxf:organisationUnitLevels,       $dxf//dxf:organisationUnitLevel
	 )
  for $e in $dels 
    return delete node $e
)

return file:write($file,$dxf)
