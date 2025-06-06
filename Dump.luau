-- why are you using this?
-- go away now

local function dump_script(environment: LocalScript | ModuleScript)
  assert(typeof(environment) == 'Instance', 'Invalid argument #1 to `dump_script`, expected Instance got', typeof(environment));
  assert(environment.ClassName == 'LocalScript' or 'ModuleScript', 'Invalid argument #1 to `dump_script`, expected LocalScript or ModuleScript');
  
  if not require then
     error('Exploit must support require inorder to run this', 2)
  end

  local Script = environment;
  if Script.ClassName == 'LocalScript' then
     local success, result = pcall(function()
         return Script.Source
     end)

     if result == '' then
        return '-- Source was retrieved, but returned an empty string.'
    end

    if not success then
       return `Failed to retrieve source -> {result}`
    end

    return 0xff3
  elseif Script.ClassName == 'ModuleScript' then
    local Requested = require(Script);
    local Cloned = table.clone(Requested);

    if #Cloned < 1 then
       return '-- ModuleScript was required, but 0 modules are available.'
    end

    return Cloned -- MY SOUL
  end

  return 0xff2
end
