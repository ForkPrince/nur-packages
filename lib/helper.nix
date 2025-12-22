{lib}: let
  githubUrl = repo: tagPrefix: version: file: "https://github.com/${repo}/releases/download/${tagPrefix}${version}/${file}";

  sanitizeName = name:
    builtins.replaceStrings
    [" " "%20"]
    ["-" "-"]
    name;

  applySubstitutions = subs: let
    applySubs = t: idx:
      if idx >= builtins.length subs
      then t
      else
        applySubs
        (builtins.replaceStrings ["{${toString idx}}"] [(builtins.elemAt subs idx)] t)
        (idx + 1);
  in
    applySubs;
in {
  read = path: builtins.fromJSON (builtins.readFile path);

  getSingle = ver: let
    hasFile = ver.asset ? file;
    isGithub = (ver.source.type or "") == "github-release" && hasFile;

    url =
      if isGithub
      then
        githubUrl
        ver.source.repo
        (ver.source.tag_prefix or "")
        ver.version
        (builtins.replaceStrings ["{version}"] [ver.version] ver.asset.file)
      else
        builtins.replaceStrings
        ["{repo}" "{version}"]
        [(ver.source.repo or "") ver.version]
        ver.asset.url;
    
    urlPath = builtins.elemAt (lib.splitString "?" url) 0;
    filename = baseNameOf urlPath;
    name = sanitizeName filename;
  in {
    inherit url name;
    inherit (ver) hash;
  };

  getPlatform = platform: ver: let
    plat = lib.getAttr platform ver.platforms;
    hasCustomUrl = plat ? url;
  in
    if hasCustomUrl
    then let
      url = builtins.replaceStrings ["{version}" "{repo}"] [ver.version (plat.repo or ver.source.repo or "")] plat.url;
      urlPath = builtins.elemAt (lib.splitString "?" url) 0;
      filename = baseNameOf urlPath;
      name = sanitizeName filename;
    in {
      inherit url name;
      inherit (plat) hash;
    }
    else let
      file = builtins.replaceStrings ["{version}"] [ver.version] plat.file;
      name = sanitizeName file;
    in {
      url =
        githubUrl
        (plat.repo or ver.source.repo)
        (plat.tag_prefix or ver.source.tag_prefix or "")
        ver.version
        file;
      inherit name;
      inherit (plat) hash;
    };

  getVariant = variant: ver: let
    vari = lib.getAttr variant ver.variants;
    hasFile = ver.asset ? file;
    isGithub = (ver.source.type or "") == "github-release" && hasFile;

    baseUrl =
      if isGithub
      then
        githubUrl
        ver.source.repo
        (ver.source.tag_prefix or "")
        ver.version
        ver.asset.file
      else
        builtins.replaceStrings
        ["{repo}" "{version}"]
        [ver.source.repo ver.version]
        ver.asset.url;
    
    url = applySubstitutions vari.substitutions baseUrl 0;
    urlPath = builtins.elemAt (lib.splitString "?" url) 0;
    filename = baseNameOf urlPath;
    name = sanitizeName filename;
  in {
    inherit url name;
    inherit (vari) hash;
  };

  getApi = ver: let
    url = ver.asset.url;
    urlPath = builtins.elemAt (lib.splitString "?" url) 0;
    filename = baseNameOf urlPath;
    name = sanitizeName filename;
  in {
    inherit url name;
    inherit (ver.asset) hash;
  };

  getApiPlatform = platform: ver: let
    plat = lib.getAttr platform ver.platforms;
    url = plat.url;

    urlPath = builtins.elemAt (lib.splitString "?" url) 0;
    filename = baseNameOf urlPath;
    name = sanitizeName filename;
  in {
    inherit url name;
    inherit (plat) hash;
  };

  unpack = ver: ver.asset.unpack or false;

  unpackPlatform = platform: ver:
    (lib.getAttr platform ver.platforms).unpack or ver.asset.unpack or false;
}
