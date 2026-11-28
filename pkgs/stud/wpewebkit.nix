# WPE WebKit is needed by Rosemary for Roblox's sign-in and web pages, but
# nixpkgs doesn't package it. Reuse Arch's binary package (the same upstream
# tarball built against a matching glibc) rather than compiling WebKit here.
{
  autoPatchelfHook,
  at-spi2-core,
  libxkbcommon,
  libseccomp,
  libwpe-fdo,
  stdenvNoCC,
  enchant_2,
  gst_all_1,
  libgcrypt,
  libsoup_3,
  fetchurl,
  harfbuzz,
  libepoxy,
  libinput,
  libjpeg8,
  libtasn1,
  libavif,
  wayland,
  hyphen,
  libdrm,
  libpng,
  libwebp,
  libxml2,
  libxslt,
  sqlite,
  cairo,
  lcms2,
  libwpe,
  woff2,
  glib,
  mesa,
  zlib,
  zstd,
  icu,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "wpewebkit";
  version = "2.54.3-1";

  src = fetchurl {
    url = "https://archive.archlinux.org/packages/w/wpewebkit/wpewebkit-${version}-x86_64.pkg.tar.zst";
    hash = "sha256-QbVWpvCWzS08xRRJzxPw62bH2IjMwqQf+CaIvun01v0=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    zstd
  ];

  buildInputs = [
    (harfbuzz.override {withIcu = true;})
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-bad
    gst_all_1.gstreamer
    at-spi2-core
    libxkbcommon
    libseccomp
    libwpe-fdo
    enchant_2
    libgcrypt
    libsoup_3
    libepoxy
    libinput
    libjpeg8
    libtasn1
    libavif
    wayland
    hyphen
    libdrm
    libpng
    libwebp
    libxml2
    libxslt
    sqlite
    cairo
    lcms2
    libwpe
    woff2
    glib
    mesa
    zlib
    icu
  ];

  autoPatchelfIgnoreMissingDeps = ["libjxl.so.0.13"];

  sourceRoot = ".";

  unpackPhase = ''
    runHook preUnpack
    tar --zstd -xf $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r usr/* $out/
    runHook postInstall
  '';

  meta = {
    description = "WPE WebKit, needed by Stud for Roblox's web pages";
    homepage = "https://wpewebkit.org";
    license = lib.licenses.lgpl2Plus;
    maintainers = with lib.maintainers; [Prinky];
    platforms = ["x86_64-linux"];
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
}
