cd D:\Godot\Touhou(fanmade)\dev_tools\get_coord_path2d
call .\.venv\Scripts\activate.bat
python .\convert.py 
%godot% -s --headless create_bullet_path_2d.gd
PAUSE