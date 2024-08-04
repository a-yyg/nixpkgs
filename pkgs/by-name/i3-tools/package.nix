{ lib
, python3Packages
, poetry
}:
with python3Packages;

buildPythonApplication rec {
  name = "i3-tools";

  src = builtins.fetchGit {
    url = "https://github.com/KJoke70/i3-tools";
    rev = "bb4bb817e8e1c1d58aa2ef43d67dc6c32eb5753d";
    ref = "master";
  };

  postPatch = ''
    mkdir i3_tools
    mv *.py i3_tools
  '';

  nativeBuildInputs = [ poetry ];
  propagatedBuildInputs = [ 
    i3ipc
    poetry-core
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
