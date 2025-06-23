{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "sbstck-dl";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "alexferrari88";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-5mVTVjaFao9XhC6b8XoDRMEaIpg1auM7RsJKw3SAlL4=";
  };

  vendorHash = "sha256-eNcINIRo/g0LFoEkh1KBob/rQSdkTsSonUogHXwD770=";

  meta = with lib; {
    description = "CLI tool for downloading Substack newsletters for archival, offline reading, or data analysis";
    homepage = "https://github.com/alexferrari88/sbstck-dl";
    license = licenses.mit;
    maintainers = [ ];
  };
}

