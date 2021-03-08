FROM fedora:32
LABEL maintainer="DALLEAU Mattis <mattis.dalleau@epitech.eu>"

RUN dnf -y upgrade                          \
        && dnf -y install dnf-plugins-core  \
        && dnf -y --refresh install         \
        SFML.x86_64                         \
        SFML-devel.x86_64                   \
        cmake.x86_64                        \
        curl.x86_64                         \
        gcc-c++.x86_64                      \
        gcc.x86_64                          \
        gdb.x86_64                          \
        git                                 \
        glibc-devel.x86_64                  \
        glibc-locale-source.x86_64          \
        glibc.x86_64                        \
        make.x86_64                         \
        nasm.x86_64                         \
        ncurses-devel.x86_64                \
        ncurses-libs                        \
        ncurses.x86_64                      \
        valgrind.x86_64                     \
        which.x86_64                        \
        vim                                 \
    && dnf clean all -y

# Large layer was splitted because build timeout on push to github package
RUN     dnf -y --refresh install            \
        emacs-nox                                       \
    && dnf clean all -y

RUN cd /tmp \
    && rpm -ivh https://github.com/samber/criterion-rpm-package/releases/download/2.3.3/libcriterion-devel-2.3.3-2.el7.x86_64.rpm

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PATH="${PATH}:/opt/gradle/gradle-6.6.1/bin"

COPY fs /

RUN cd /tmp \
    && bash build_csfml.sh \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp
