# build stage
FROM python:3.12-slim-bookworm AS builder

# install PDM
RUN pip install -U pip setuptools wheel
RUN pip install pdm

# copy files
COPY pyproject.toml pdm.lock README.md /app/
COPY src/ /app/src

# install dependencies and project into the local packages directory
WORKDIR /app
RUN mkdir __pypackages__ && pdm sync --prod --no-editable


# run stage
FROM python:3.12-slim-bookworm

# retrieve packages from build stage
ENV PYTHONPATH=/app/pkgs
COPY --from=builder /app/__pypackages__/3.12/lib /app/pkgs
# retrieve executables
COPY --from=builder /app/__pypackages__/3.12/bin/* /bin/
# copy files
COPY --from=builder /app/pyproject.toml /app/pdm.lock /app/README.md /app/
COPY --from=builder /app/src/ /app/src

WORKDIR /app/src

# set command/entrypoint, adapt to fit your needs
# uvicorn app:app --reload --host 0.0.0.0 --port 8000
CMD ["uvicorn", "app:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]