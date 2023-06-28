FROM 		archlinux:latest
ENTRYPOINT	[ "/bin/fish" ]

ARG         USER $USER
ENV			USER $USER

RUN			pacman -Syu  --noconfirm \
			fish \
			base-devel \
			gcc \
			make \
			cmake \
			readline \
			valgrind \
			man-db \
			man-pages \
			nano \
			curl \
			git \
			difftastic \
			lsof \
			lldb \
			diffutils \
			moreutils \
			python3	\
			glfw \
			netcat \
			xorg-server \
			xorg-xinit \
			sudo 

RUN			source "/etc/profile.d/debuginfod.sh"
RUN			chsh -s /bin/fish
RUN			useradd -ms /bin/fish -rg root $USER
RUN			echo "$USER ALL=(ALL) ALL" >> /etc/sudoers
RUN			echo "$USER:root" | chpasswd

RUN			mkdir -p /etc/fish
COPY		config.fish /etc/fish/config.fish
USER		$USER

WORKDIR		"/home/$USER"

RUN			python3 -m venv /home/$USER/arch/norminette && \
			/home/$USER/arch/norminette/bin/pip install --upgrade pip setuptools norminette

ENV			PATH="/home/$USER/arch/norminette/bin:${PATH}"

RUN			git config --global credential.helper store 

RUN			find /home/$USER/.vscode-server/extensions/*/bin/ -type f -name 'cpptools*' -exec chmod +x {} \; || true