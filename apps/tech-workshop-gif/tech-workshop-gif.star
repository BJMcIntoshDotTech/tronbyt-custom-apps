load("http.star", "http")
load("render.star", "render")
load("schema.star", "schema")

def main(config):
    gif_url = config.get("gif_url", "")
    if not gif_url:
        fail("Enter the GIF URL in the app settings.")

    response = http.get(gif_url)
    if response.status_code != 200:
        fail("GIF request failed with HTTP status %d", response.status_code)

    image = render.Image(src=response.body())

    return render.Root(
        delay=image.delay,
        child=image,
    )

def get_schema():
    return schema.Schema(
        version="1",
        fields=[
            schema.Text(
                id="gif_url",
                name="GIF URL",
                desc="HTTP URL of the animated 192x64 GIF.",
                icon="image",
                default="",
            ),
        ],
    )
