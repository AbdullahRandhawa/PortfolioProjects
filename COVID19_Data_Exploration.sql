/*

Covid 19 Data Exploration

Skills used: Window functions, Aggeregate Functions, Temp Tables, CTE's, Joins, Creating Views, Converting Types

*/


SELECT *
FROM PortfoliProject..CovidDeaths
where continent is null
order by 3,4


-- Select data that we are going to use

Select location, date, total_cases, new_cases, total_deaths, population
FROM PortfoliProject..CovidDeaths
where continent is not null
order by 1,2


-- Locking for total cases vs total deaths

Select location, date, total_cases, total_deaths,(cast(total_deaths as int)/(total_cases))*100 as death_rate
FROM PortfoliProject..CovidDeaths
where continent is not null
order by 1,2


-- Death Rate in Pakistan during covid

Select location, date, total_cases, total_deaths, (cast(total_deaths as int)/(total_cases))*100 as death_rate
FROM PortfoliProject..CovidDeaths
WHERE location = 'pakistan'
order by 1,2


-- Total Cases vs Population
-- Shows what percentage of population got covid

Select location, date, population, total_cases, (total_cases/population)*100 as cases_percentage
FROM PortfoliProject..CovidDeaths
where continent is not null
order by 1,2


-- Cases_percentage in pakistan

Select location, date, population, total_cases, (total_cases/population)*100 as cases_percentage
FROM PortfoliProject..CovidDeaths
where location = 'Pakistan'
order by 1,2


-- Looking at countries with highest infection rate

Select location, population, max(total_cases) as max_cases, max((total_cases/population))*100 as cases_percentage
FROM PortfoliProject..CovidDeaths
where continent is not null
GROUP BY location, population
order by cases_percentage desc


-- Showing countries with highest death count

SELECT location, max(cast(total_deaths as int)) as max_deaths
FROM PortfoliProject..CovidDeaths
where continent is not null
group by location
order by max_deaths desc


-- Shows Continent with highest death count

SELECT continent, max(cast(total_deaths as int)) as max_deaths
FROM PortfoliProject..CovidDeaths
where continent is not null
group by continent
order by max_deaths desc


-- Global Numbers

-- Global numbers of total cases , deaths deaths count and deth percentage of every day

SELECT date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 as death_percentage
FROM PortfoliProject..CovidDeaths
where continent is not null
group by date
order by 1,2


-- Global number of Total Cases , Total Deaths and Death rate per total cases

SELECT sum(population) as total_population, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 as death_percentage
FROM PortfoliProject..CovidDeaths
where continent is not null
--group by date
order by 1,2


-- Show at Total population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int))
OVER(partition by dea.location order by dea.date) as rolling_people_vaccinated
FROM PortfoliProject..CovidDeaths dea
JOIN PortfoliProject..CovidVaccinations vac
	ON dea.location=vac.location
	and dea.date=vac.date
where dea.continent is not null
order by 2,3 



-- Use CTE to find people vacinated vs population 

With pop_vs_vac (Continent,Location,Date,Population,New_vaccinations,rolling_people_vaccinated) as
(
SELECT dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int))
OVER(partition by dea.location order by dea.date) as rolling_people_vaccinated
FROM PortfoliProject..CovidDeaths dea
JOIN PortfoliProject..CovidVaccinations vac
	ON dea.location=vac.location
	and dea.date=vac.date
where dea.continent is not null
)
SELECT *,(rolling_people_vaccinated/population)*100 as vaccinated_percentage
from pop_vs_vac



-- Temp table

Drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
rolling_people_vaccinated numeric
)

Insert into  #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int))
OVER(partition by dea.location order by dea.date) as rolling_people_vaccinated
FROM PortfoliProject..CovidDeaths dea
JOIN PortfoliProject..CovidVaccinations vac
	ON dea.location=vac.location
	and dea.date=vac.date
where dea.continent is not null

SELECT *,(rolling_people_vaccinated/population)*100 as vaccinated_percentage
from #PercentPopulationVaccinated



-- Creating view to store data for later visualization

Create view PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int))
OVER(partition by dea.location order by dea.date) as rolling_people_vaccinated
FROM PortfoliProject..CovidDeaths dea
JOIN PortfoliProject..CovidVaccinations vac
	ON dea.location=vac.location
	and dea.date=vac.date
where dea.continent is not null 

select*
from PercentPopulationVaccinated

--End
