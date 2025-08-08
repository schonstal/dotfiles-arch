function gut --description 'run godot unit tests'
  if [ -e project.godot ];
    if [ -z "$argv" ];
      godot --headless -s addons/gut/gut_cmdln.gd -gdir=test/
      return
    else
      godot --headless -s addons/gut/gut_cmdln.gd -gdir=$argv[1]
      return
    end
  else
    echo "Could not find project.godot" 1>&2
  end
end
