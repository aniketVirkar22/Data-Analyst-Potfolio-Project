
SELECT * 
FROM CovidDeaths
ORDER BY 3,4

SELECT * 
FROM CovidVaccinations
ORDER BY 3,4

--Selecting the reuired data
SELECT location,date,total_cases,new_cases,total_deaths,population
FROM CovidDeaths

--Total cases to Total deaths
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS DeathToCases
FROM CovidDeaths
WHERE total_deaths IS NOT NULL
ORDER BY 1,2

--Total cases to population%
SELECT location, total_cases, population, (total_cases/population)*100 AS CasesToPopulation
FROM CovidDeaths
WHERE location like '%India%'
ORDER BY 1,2

--Death Percentage
SELECT location, date,population, total_deaths, (total_deaths/population)*100 AS DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%India' 
ORDER BY DeathPercentage ASC

--Highest death counts country wise
SELECT location, MAX(cast(total_deaths as int)) AS DeathCounts
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY DeathCounts DESC

--Highest deaths by continent
SELECT continent, MAX(cast(total_deaths as int)) AS DeathsByCovid
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY DeathsByCovid DESC 

--Global death percentage
SELECT SUM(total_cases) AS Total_Covid_Cases , SUM(cast(total_deaths as int)) AS Total_Deaths_By_Covid, SUM(cast(total_deaths as int)) / SUM(total_cases)*100 AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY Death_Percentage DESC

--Joining the 2 tables
SELECT * 
FROM CovidDeaths deaths
JOIN CovidVaccinations vacc
ON deaths.location = vacc.location