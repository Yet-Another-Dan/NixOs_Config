{stdenv, fetchFromGitHub}:
{
	sddm-astronaut-theme = stdenv.mkDerivation rec{
		pname = "sddm-astronaut-theme";
		version = "3ef9f511fd072ff3dbb6eb3c1c499a71f338967e";
		dontBuild = true;
		installPhase = ''
			mkdir -p $out/share/sddm/themes
			cp -aR $src $out/share/sddm/themes/sddm-astronaut-theme
			'';
		src = fetchFromGitHub {
			owner = "Keyitdev";
			repo = "sddm-astronaut-theme";
			rev = "${version}";
			sha256 = "sha256-33CzZ4vK1dicVzICbudk8gSRC/MExG+WnrE9wIWET14=";
		};
	};
}
