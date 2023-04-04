--Covid Data Exploration 
--Skills Showcased: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

-- TOTAL CASES VS TOTAL DEATHS
-- Likelihood of dying if you contract covid in your country (United States for example)
Select Location, date, total_cases, total_deaths, (total_deaths * 1.0 /total_cases) * 100 as DeathPercentage --multiplied total deaths by 1.0 to change integers to floats
FROM CovidDeaths
WHERE location like '%states%';


--Percentage of population that got Covid
Select Location, date, Population, total_cases, (total_cases * 1.0 /population) * 100 as InfectionPercentage --multiplied total cases by 1.0 to change integers to floats
FROM CovidDeaths
WHERE location like '%states%';

--Countries with Highest Infection Rate Compared to Population
Select Location, Population, max(cast(total_cases as int)) as HighestInfectionCount, MAX((total_cases * 1.0 /population) * 100) as InfectionPercentage --multiplied total cases by 1.0 to change integers to floats
FROM CovidDeaths
GROUP BY Location, Population
ORDER BY InfectionPercentage desc;

--Showing countries with their highest death count 
Select Location, max(cast(total_deaths as int)) as HighestDeathCount 
FROM CovidDeaths
WHERE continent is not null
GROUP BY Location
ORDER BY HighestDeathCount desc;

--Showing continents with their highest death count 
Select continent, max(cast(total_deaths as int)) as HighestDeathCount 
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY HighestDeathCount desc;

--Global Numbers
Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_death, (SUM(new_deaths)*1.0)/SUM(new_cases)*100 as DeathPercentage  --SUM(New_Cases)/SUM(new_deaths)*100 as DeathPercentage
FROM CovidDeaths
WHERE continent is not null;

-- Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Cast(vac.new_vaccinations as INT)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
from CovidDeaths dea
Join CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null;

-- Use CTE For Calculation on Partition By In Previous Query
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Cast(vac.new_vaccinations as INT)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
from CovidDeaths dea
Join CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null)
Select *, (RollingPeopleVaccinated*1.0/Population)*100 FROM PopvsVac;

--Temp Table For Calculation on Partition by in Previous Query
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated(Continent nvarchar(255), Location nvarchar(255), Date datetime, Population numeric, New_vaccinations numeric, RollingPeopleVaccinated numeric)
INSERT INTO #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Cast(vac.new_vaccinations as INT)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated 
from CovidDeaths dea
Join CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null)
Select *, (RollingPeopleVaccinated*1.0/Population)*100 FROM #PercentPopulationVaccinated;

-- Creating view of ContinentMaxDeaths to store data for later visualizations
Create View ContinentMaxDeaths as
Select continent, max(cast(total_deaths as int)) as HighestDeathCount 
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY HighestDeathCount desc;
