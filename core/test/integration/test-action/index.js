const core = require('@actions/core');
const exec = require('@actions/exec');
const path = require('path');

async function run() {
    try {
        await exec.exec('ls');
        process.exitCode = await exec.exec('dart', ['core/test/integration/test-action/main.dart']);
    } catch (error) {
        core.setFailed(error.message);
    }
}

run();