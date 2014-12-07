#ifndef __CLIENT_SYSTEM_H__
#define __CLIENT_SYSTEM_H__

// Copyright 2010 Alon Zakai ('kripken'). All rights reserved.
// This file is part of Syntensity/the Intensity Engine, an open source project. See COPYING.txt for licensing.

//! System management for the client: usernames, passwords, logging in, client numbers, etc.

struct ClientSystem
{
    //! An identifier for the current scenario the client is active in. Used to check with the
    //! server, when the server starts a new scenario, to know when we are in sync or not
    static string currScenarioCode;

    //! Marks the status as not logged in. Called on a disconnect from sauer's client.h:gamedisconnect()
    static void onDisconnect();

    //! Whether the scenario has actually started, i.e., we have received everything we need from the server to get going
    static bool scenarioStarted();

    static void finishLoadWorld();

    static void prepareForNewScenario(const char *sc);
};

#endif
