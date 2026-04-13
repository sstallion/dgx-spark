# spark-docker

[![](https://img.shields.io/github/license/sstallion/spark-docker.svg)][1]

spark-docker is a Docker Compose setup for a self-hosted AI home server. It
orchestrates [vLLM][2] for local LLM inference, [Bifrost][3] as an AI gateway,
and [Open WebUI][4] as a chat interface, all served through a [Caddy][5] reverse
proxy with TLS.

## Getting Started

> [!IMPORTANT]
> Docker with the Compose plugin and NVIDIA drivers with GPU support are required
> to run this project. A Hugging Face account and access token are also required
> to download model weights.

Build the images:

```shell
docker compose build
```

Start services:

```shell
docker compose up -d
```

> [!NOTE]
> The active model profile is controlled by `COMPOSE_PROFILES` in `.env`. See
> [Configuration](#configuration) for details.

### Services

The following services are defined in `compose.yaml`:

| Service | Description |
|---------|-------------|
| `home` | Caddy-based homepage and reverse proxy |
| `bifrost` | High-performance AI gateway ([Bifrost v1.4.22][3]) |
| `open-webui` | Self-hosted AI chat interface ([Open WebUI][4]) |
| `vllm-Qwen3-Coder-Next` | vLLM serving `Intel/Qwen3-Coder-Next-int4-AutoRound` |
| `vllm-gemma-4-26B-A4B-it` | vLLM serving `cyankiwi/gemma-4-26B-A4B-it-AWQ-4bit` |

The homepage is accessible at `https://<hostname>.local` once services are
running. Bifrost and Open WebUI are proxied on ports `4000` and `8080`
respectively.

### Configuration

Service configuration is driven by environment variables in `.env`. The most
important variable is `COMPOSE_PROFILES`, which selects the active vLLM model:

```shell
COMPOSE_PROFILES=Qwen3-Coder-Next
```

A Hugging Face access token must be exported before starting services so that
model weights can be downloaded:

```shell
export HF_TOKEN=<your-token>
```

## Contributing

Pull requests are welcome! See [Contributing][6] for details.

## License

Source code in this repository is licensed under the MIT License. See
[LICENSE][1] for details.

[1]: https://github.com/sstallion/spark-docker/blob/main/LICENSE
[2]: https://github.com/vllm-project/vllm
[3]: https://github.com/maximhq/bifrost
[4]: https://github.com/open-webui/open-webui
[5]: https://caddyserver.com/
[6]: https://github.com/sstallion/spark-docker/blob/main/CONTRIBUTING.md
