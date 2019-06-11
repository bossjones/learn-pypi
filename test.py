import click
import pyconfig
from typing import Any, Tuple
# from . import commands
# from .logging import getLogger
# from .process import fail
import logging

logger = logging.getLogger(__name__)

# http://click.palletsprojects.com/en/5.x/options/
# http://click.palletsprojects.com/en/5.x/complex/#complex-guide
# http://click.palletsprojects.com/en/5.x/commands/


@click.group()
@click.option("--working-dir", envvar="BOSSPACKAGE_WORKING_DIR", default="working_dir")
@click.option("--config-dir", envvar="BOSSPACKAGE_CONFIG_DIR", default="config")
@click.option("--debug", is_flag=True, envvar="BOSSPACKAGE_DEBUG")
@click.pass_context
def cli(ctx, working_dir: str, config_dir: str, debug: bool):
    """
    BOSSPACKAGEctl - Client Side CLI tool to manage an BOSSPACKAGE Cluster.
    """
    click.echo(f"debug={debug}")

    set_flag("working-dir", working_dir)
    set_flag("config-dir", config_dir)
    set_flag("debug", debug)
    # pass


@cli.command()
def dummy():
    """
    Dummy command, doesn't do anything.
    """

    click.echo("Dummy command, doesn't do anything.")


@cli.command()
@click.option("--fact", multiple=True, help="Set a fact, like --fact=color:blue.")
def info(fact: Tuple[str]):
    """Get info on running BOSSPACKAGE process."""
    logger.debug("info subcommand called from cli")
    set_fact_flags(fact)
    # commands.info()

def set_flag(flag: str, value: Any) -> None:
    """Store a CLI flag in the config as "cli.flags.FLAG"."""
    pyconfig.set(f"cli.flags.{flag}", value)


def get_flag(flag: str, default: Any = None) -> Any:
    """Get a CLI flag from the config."""
    return pyconfig.get(f"cli.flags.{flag}", default)


def set_fact_flags(flag_args: Tuple[str]) -> None:
    """Take "--fact" flags from the CLI and store them in the config as a dict."""
    facts = {}

    for arg in flag_args:
        if ":" not in arg:
            logger.critical('Arguments to "--fact" must be colon seperated.')
            logger.critical('Like: "BOSSPACKAGEctl --fact=temperature:hot')
            # fail()
        fact, value = arg.split(":", 1)
        logger.debug(f'Setting fact from cli: "{fact}" -> "{value}"')
        facts[fact] = value

    set_flag("fact", facts)
