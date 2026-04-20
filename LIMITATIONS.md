# Limitations

Apache Maven is a Java build tool distributed by the Apache Software Foundation.
This cookbook manages Maven through custom resources and assumes a Linux/Unix
layout with an already-installed JDK.

## Distribution model

The cookbook installs Maven from the upstream Apache binary tarball through the
`ark` cookbook. It does not manage distro packages.

| Channel | Source | Notes |
|---------|--------|-------|
| Binary tarball | <https://archive.apache.org/dist/maven/> | Canonical source for released versions |
| Binary tarball (current) | <https://dlcdn.apache.org/maven/> | Current releases only |
| Debian/Ubuntu `apt` | `maven` package | Not used by this cookbook |
| RHEL/Fedora `dnf` | `maven` package | Not used by this cookbook |

## Supported platforms

The cookbook follows the platforms declared in `metadata.rb`:

- AlmaLinux 8+
- Amazon Linux 2023+
- Debian 12+
- Debian 13+
- Fedora
- Rocky Linux 8+
- Ubuntu 22.04+

## Architectures

- `x86_64`
- `aarch64` / `arm64`

Maven itself is architecture-independent, but the host JDK must support the
target architecture.

## JDK prerequisites

- Maven 3.9.x requires JDK 8 or later
- Maven 4.x requires JDK 17 or later

This cookbook does not install Java. Callers must ensure a compatible JDK is
available before `maven_install` or `maven_artifact` is used.

## Resource behavior constraints

- `maven_install` is designed for a single system-wide installation. It manages
  a shared install directory, writes one `mavenrc` file, and removes the
  `/usr/local/bin/mvn` symlink when uninstalling.
- `maven_artifact` shells out to `mvn`, so Maven and Java must already be on
  `PATH` when the resource runs.
- `maven_artifact :delete` removes both the versioned install filename
  (`artifact-version[-classifier].packaging`) and the custom `:put` filename
  (`resource_name.packaging`).
- `maven_settings` updates an existing `settings.xml` file in place. The target
  file and the dotted XML path must already exist.
