{ lib
, python3Packages
, poetry
}:
with python3Packages;

buildPythonApplication rec {
  name = "i3-rotate";

  src = builtins.fetchGit {
    url = "https://github.com/heyitsxavier/i3-rotate";
    rev = "09b5039bc6d6c466b6e9e7c8885413d1a6755511";
    ref = "master";
  };

  postPatch = ''
    mkdir i3_rotate
    mv *.py i3_rotate/
  '';

  nativeBuildInputs = [ poetry ];
  propagatedBuildInputs = [ 
    poetry-core
    i3ipc
  ];

  pyproject = true;

  preBuild = ''
    cp ${./pyproject.toml} ./pyproject.toml
  '';

  postInstall = ''
    for f in $out/bin/*.py; do
      mv $f ''${f%.py}
    done
  '';
}
