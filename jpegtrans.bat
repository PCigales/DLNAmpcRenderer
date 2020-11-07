@setlocal enabledelayedexpansion
@"C:\Program Files (x86)\ExifTool\jhead_jpegtran\jpegtran.exe" -copy none -rotate !jpegtrans_rot! !jpegtrans_input! !jpegtrans_output!
@endlocal