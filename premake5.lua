workspace "SDL3_GPU_Example"
  configurations { "Debug", "Release" }
  architecture "x64"
  startproject "SDL3App"

  OutputDir = "%{cfg.system}-%{cfg.architecture}/%{cfg.buildcfg}"
  local sdl3_root  = path.getabsolute("vendor/SDL3")
  local sdl3_build = path.join(sdl3_root, "build")
  local cmakeExe = path.getabsolute("vendor/cmake/bin/cmake.exe")

  -- SDL_shadercross
  project "SDL_shadercross"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"
    targetdir ("Binaries/" .. OutputDir .. "/%{prj.name}")
    objdir    ("Binaries/Intermediates/" .. OutputDir .. "/%{prj.name}")

    dependson { "SDL3" }

    files {
      "vendor/SDL_shadercross/src/SDL_shadercross.c",
        "vendor/SDL_shadercross/external/SPIRV-Cross/*.cpp"
    }

    includedirs {
        "vendor/SDL3/include",
        "vendor/SDL_shadercross/include",
        "vendor/SDL_shadercross/external/SPIRV-Headers/include",
        "vendor/SDL_shadercross/external/SPIRV-Cross",
        "vendor/SDL_shadercross/external/SPIRV-Tools/include",
        "vendor/SDL_shadercross/external/DirectXShaderCompiler/include"
    }

    libdirs {
      "%{wks.location}/vendor/SDL3/build/%{cfg.buildcfg}"
    }

    links { "SDL3" }

    filter "system:windows"
      systemversion "latest"
      postbuildcommands {
        "{COPY} \"vendor/SDL3/build/Debug/SDL3.dll\" \"%{cfg.targetdir}\""
      }
    filter "configurations:Debug"
      runtime "Debug"; symbols "On"
    filter "configurations:Release"
      runtime "Release"; optimize "On"


  -- SDL3App
  project "SDL3App"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    staticruntime "on"
    targetdir ("Binaries/" .. OutputDir .. "/%{prj.name}")
    objdir    ("Binaries/Intermediates/" .. OutputDir .. "/%{prj.name}")

    dependson { "SDL3", "SDL_shadercross" }

    files { "src/**.h", "src/**.cpp" }

    includedirs {
      "vendor/SDL3/include",
	  "vendor/SDL3/build/include-config-debug",
      "vendor/SDL_shadercross/include",
      "vendor/SDL_shadercross/external/SPIRV-Headers/include",
    }

    libdirs {
      "%{wks.location}/vendor/SDL3/build/%{cfg.buildcfg}"
    }

    links {
      "SDL3",
      "SDL_shadercross"
    }

    filter "system:windows"
      systemversion "latest"
      postbuildcommands {
        "{COPY} \"vendor/SDL3/build/Debug/SDL3.dll\" \"%{cfg.targetdir}\""
      }
    filter "configurations:Debug"
      runtime "Debug"; symbols "On" 
    filter "configurations:Release"
      runtime "Release"; optimize "On"
