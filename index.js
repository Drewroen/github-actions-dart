const core = require('@actions/core');
const exec = require('@actions/exec');
const path = require('path');

async function run() {
    try {
        process.exitCode = await exec.exec('dart', ['test-action/main.dart']);
    } catch (error) {
        core.setFailed(error.message);
    }
}

run();