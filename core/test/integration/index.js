const core = require('@actions/core');
const exec = require('@actions/exec');

async function run() {
    try {
        test_path = core.getInput('TEST_PATH');
        process.exitCode = await exec.exec('dart', [test_path]);
    } catch (error) {
        core.setFailed(error.message);
    }
}

run();