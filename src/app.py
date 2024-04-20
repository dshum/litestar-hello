from litestar import Litestar, get


@get("/")
async def index() -> dict[str, str]:
    return {"status": "OK"}


app = Litestar([index])
